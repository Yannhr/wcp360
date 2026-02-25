# 🗄️ WCP360 Database Architecture

WCP360 employs a dual-layer database strategy: **Internal State Persistence** (for panel orchestration) and **Managed Workload Services** (for customer websites).

---

## 1. Internal Panel Database (Metadata Store)

The internal data for WCP360 is stored using an embedded approach to minimize external dependencies, simplify deployments, and ensure near-zero latency.

### Storage Engine: SQLite 3 (WAL Mode)
* **Location:** `/var/lib/wcp360/state.db`
* **Role:** Stores users, domains, hosting plans, API keys, task queues, and audit metadata.
* **Why?** SQLite in **Write-Ahead Logging (WAL)** mode allows concurrent reads and writes. It is the gold standard for local system management tools.
* **Go Integration:** Built using the pure-Go SQLite driver (`modernc.org/sqlite`) to maintain a CGO-free, portable binary.



---

## 2. Managed Customer Databases (The Workload)

WCP360 orchestrates enterprise-grade database engines to power customer applications.

### Supported Engines
* **MariaDB (Default):** High-performance MySQL fork optimized for shared hosting.
* **PostgreSQL:** For advanced relational and JSONB-heavy workloads.

### 🛡️ Isolation & Security Model
* **Socket-First Policy:** Applications communicate with databases via **Unix Domain Sockets** (`/var/run/mysqld/mysqld.sock`) to bypass the network stack, reducing latency by ~15%.
* **One Database, One User:** Strict 1:1 mapping enforced by the panel. A database user is physically restricted from accessing or seeing other databases.
* **Resource Jailing:** Database processes are grouped within the specific **systemd-slice** of the owner. DB usage is calculated as part of the user's **Elastic Resource Limit**.



---

## 3. Schema Design Principles

Every table in the WCP360 internal schema follows these strict Go-ready rules:

| Rule | Description |
| :--- | :--- |
| **UUIDs** | All primary keys use UUID v4 to support future multi-node clustering without ID collisions. |
| **JSONB Fields** | Used for flexible module metadata without requiring frequent schema migrations. |
| **Audit Timestamps** | Every row includes `created_at`, `updated_at`, and `deleted_at` (Soft Delete). |
| **Referential Integrity** | Foreign key constraints are enforced at the engine level to ensure data consistency. |

---

## 4. Backup & Disaster Recovery Strategy

### Atomic Snapshots
WCP360 wraps native tools like `mysqldump` or `pg_dump` into **Go Pipes**. This allows data to be streamed and compressed on-the-fly, preventing large, unencrypted temporary files from filling up the disk.

### Point-in-Time Recovery (PITR)
* Binary logging (Binlogs) is enabled by default for MariaDB.
* The `wcp backup` command handles log rotation and off-site synchronization to S3-compatible storage.

---

## 5. Multi-Node / Cluster Strategy (Future)

In a distributed environment:
1. **Manager Node:** Holds the primary SQLite state and distributes configurations.
2. **Worker Nodes:** Run local MariaDB/PostgreSQL instances to ensure **Data Locality** (keeping the data physically close to the PHP/Go application).

---

# 🗄️ WCP360 Database Architecture & Technical Schema

This document defines the relational structure of the WCP360 hosting platform. The architecture is designed for **High Concurrency**, **Multi-Tenant Isolation**, and **Scalable Orchestration**.

---

## 🏗️ 1. Multi-Tenant Foundation (The Core)

The `tenants` table is the root of the entire ecosystem. Every hosting resource (Domains, DBs, Files) MUST cascade from here to ensure strict isolation.

| Table | Field | Type | Constraints | Description |
| :--- | :--- | :--- | :--- | :--- |
| **tenants** | `id` | UUID | PK, Default: v4 | Unique identifier for the hosting account. |
| | `name` | VARCHAR(255) | Unique | Display name of the account (e.g., "Company-A"). |
| | `owner_id` | UUID | FK (users.id) | Primary administrative user of this tenant. |
| | `package_id` | UUID | FK (packages.id) | Linked hosting plan determining the limits. |
| | `status` | ENUM | active, suspended, locked | Current account state (Suspended blocks all traffic). |
| | `reseller_id` | UUID | FK (resellers.id), NULL | Link to parent reseller if applicable. |



---

## 🔐 2. Identity & RBAC (Security Layer)

We use a granular **Role-Based Access Control** model. A user can exist outside a tenant (System Admin) or inside one (Tenant User).

| Table | Field | Type | Description |
| :--- | :--- | :--- | :--- |
| **users** | `id` | UUID (PK) | Unique user identifier. |
| | `email` | VARCHAR(255) | Unique, indexed. Primary login identifier. |
| | `password_hash` | TEXT | Argon2 or bcrypt hash. |
| | `tenant_id` | UUID (FK) | NULL for System Admins; required for clients. |
| **roles** | `id` | UUID (PK) | e.g., `system_admin`, `reseller`, `user`. |
| | `scope` | VARCHAR(50) | `global`, `reseller`, or `local`. |
| **permissions**| `id` | VARCHAR(100) | Unique key (e.g., `domain.create`, `ssh.access`). |
| **user_roles** | `user_id`, `role_id`| Composite PK | Maps users to one or more roles. |



---

## 📦 3. Hosting Packages & Limits (The Guardrails)

Limits are enforced by the Go Daemon by comparing `package_limits` (the quota) vs `tenant_usage` (the consumption).

| Table | Field | Type | Metric Description |
| :--- | :--- | :--- | :--- |
| **packages** | `id` | UUID (PK) | Plan identifier (e.g., "Basic", "Pro"). |
| | `is_system` | BOOLEAN | If true, protected from reseller deletion. |
| **package_limits**| `max_domains` | INT | Maximum FQDNs allowed. |
| | `max_disk_mb` | BIGINT | Total storage quota in MB. |
| | `max_cpu_pct` | INT | CPU burst limit via **cgroups v2**. |
| | `max_mem_mb` | INT | RAM limit via **cgroups v2**. |
| | `features` | JSONB | Flags: `{"ssh": true, "git": false, "api": true}`. |

---

## ⚡ 4. Real-time Usage Tracking

This table is updated atomically by the reconciliation loops to ensure immediate limit enforcement.

| Table | Field | Type | Logic |
| :--- | :--- | :--- | :--- |
| **tenant_usage** | `tenant_id` | UUID (FK) | Reference to the owner. |
| | `used_disk_mb` | BIGINT | Aggregated size of web + mail + db. |
| | `used_domains` | INT | Current count of active domains. |
| | `cpu_usage_avg` | FLOAT | 5-min rolling average from **Kernel PSI**. |
| | `bandwidth_tx` | BIGINT | Transmitted bytes (Monthly reset). |



---

## 🌐 5. Resource Inventory (The Workloads)

Every resource table strictly enforces the `tenant_id` foreign key.

| Table | Key Fields | Constraints | Integration |
| :--- | :--- | :--- | :--- |
| **domains** | `tenant_id`, `fqdn`, `status` | Unique(fqdn) | Linked to **Nginx/Gateway** Vhosts. |
| **databases** | `tenant_id`, `name`, `engine` | Unique(name) | Linked to **MariaDB/Postgres**. |
| **mail_boxes** | `tenant_id`, `address`, `quota` | Unique(address) | Linked to **Dovecot/Postfix**. |
| **cron_jobs** | `tenant_id`, `command` | - | Linked to **Systemd Timers**. |

---

## 🕵️ 6. Audit & Persistence Logic

### Audit Trail
* **audit_logs:** `id`, `actor_user_id`, `tenant_id`, `action_code`, `metadata (JSONB)`, `ip_address`, `checksum`.
* *Integrity:* Every entry contains a HMAC of the previous entry to prevent log tampering.

### Data Integrity Rules
1. **Transactions:** Any provisioning (User + Tenant + Directory) must be wrapped in a database transaction.
2. **Soft Deletes:** Records use `deleted_at` to allow for 30-day data recovery before permanent wipe.
3. **UUID v4 Only:** No integer auto-increments for primary keys to ensure global uniqueness for **Cluster Mode**.

---

## 🚀 Recommended Implementation
* **Primary DB:** PostgreSQL 15+ (for JSONB performance and Referential Integrity).
* **Internal State Cache:** SQLite 3 (for the `wcpd` local task queue and ephemeral state).


```
# Update and install PostgreSQL engine
sudo apt update && sudo apt install postgresql postgresql-contrib

# Create the dedicated WCP360 database user
sudo -u postgres psql -c "CREATE USER wcp_admin WITH PASSWORD 'secure_password_here';"

# Create the production database owned by the admin
sudo -u postgres psql -c "CREATE DATABASE wcp360_prod OWNER wcp_admin;"

# Enable UUID extension (Required for our UUID v4 primary keys)
sudo -u postgres psql -d wcp360_prod -c 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'
```
