# 🗺️ WCP360 Technical Roadmap v1.0

This roadmap outlines the technical path to build WCP360 from an empty repository to a production-ready, Go-native hosting control panel.

---

## 🏗️ Priority 1: Core Scaffolding (The Skeleton)
*Goal: Establish the FHS-compliant environment and the Go binary lifecycle.*

- [ ] **Standard Project Layout:** Implement [Golang Standards](https://github.com/golang-standards/project-layout) (`/cmd`, `/internal`, `/pkg`).
- [ ] **Daemon Lifecycle:** Develop `wcpd` with signal handling (`SIGTERM`, `SIGHUP`) and graceful shutdown.
- [ ] **Unified Installer:** Bash script to automate:
    - PostgreSQL 15+ installation & performance tuning.
    - System user `wcp360` creation.
    - FHS directory structure (`/opt/wcp360`, `/etc/wcp360`, `/var/lib/wcp360`).
- [ ] **Configuration Engine:** Implement a YAML/Env provider using `Viper` with strict validation.



---

## 🔐 Priority 2: Security & Identity Layer
*Goal: Secure the panel and implement the First-Boot mode.*

- [ ] **PAM Integration:** CGO bindings or Go-wrapper for `/etc/pam.d/common-auth` to verify root credentials.
- [ ] **First-Boot State Machine:** Logic to detect `system_initialized = false` and route to the Bootstrap API.
- [ ] **Relational Schema:** Deploy the GORM-based schema for Roles (RBAC), Tenants, and Domains.
- [ ] **JWT Provider:** Secure token issuance for API and CLI authentication.



---

## 🚀 Priority 3: Workload Orchestration (The MVP)
*Goal: Automated provisioning of web and system resources.*

- [ ] **Linux User Provisioning:** Automated creation of isolated system users and home directories.
- [ ] **Nginx Config Engine:** Go-template based generator for optimized HTTP/2 & HTTP/3 vHosts.
- [ ] **PHP-FPM Manager:** Dynamic generation of FastCGI Unix sockets and isolated pools per tenant.
- [ ] **ACME/SSL Client:** Automated SSL lifecycle management via Let's Encrypt.



---

## 📊 Priority 4: Resource Isolation (Cgroups v2)
*Goal: Multi-tenancy stability and "Noisy Neighbor" prevention.*

- [ ] **Cgroups v2 Implementation:** Direct interface with `/sys/fs/cgroup` to enforce:
    - `memory.high` / `memory.max` limits.
    - `cpu.max` (quota and period).
    - `io.max` (BPS/IOPS limits).
- [ ] **Disk Quotas:** Implement XFS Project Quotas or ext4 user-level quotas for `/srv/www/`.
- [ ] **PSI Monitoring:** Integrate Pressure Stall Information for real-time resource health metrics.



---

## 🛠️ Priority 5: Management & Observability
*Goal: External tools and data management.*

- [ ] **Database Manager:** Driver-based orchestration for MariaDB/PostgreSQL (DB/User creation).
- [ ] **Internal REST API:** Decouple the backend from the frontend via a JSON API.
- [ ] **Emergency CLI:** `wcp` command-line utility for low-level system overrides.
- [ ] **Health Dashboard:** Basic monitoring of system metrics (Load, RAM, Disk).

---

## 📈 Development Status Matrix

| Component | Priority | Complexity | Status |
| :--- | :--- | :--- | :--- |
| **System Skeleton** | 🔴 Critical | Medium | 📅 Planned |
| **PAM Auth** | 🔴 Critical | High | 📅 Planned |
| **Nginx Logic** | 🟠 High | Medium | 📅 Planned |
| **Cgroups v2** | 🟠 High | High | 📅 Planned |
| **Web UI** | 🟡 Medium | Low | 📅 Planned |

---

### 🏛️ Architectural Guarantees
1. **Go-Native:** Avoid external shell wrappers; use direct Linux API interactions where possible.
2. **Atomics:** All system changes must support rollback (Idempotency).
3. **FHS Compliance:** Respect the Filesystem Hierarchy Standard for all data and binaries.
