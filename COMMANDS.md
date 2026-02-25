# ⌨️ WCP360 CLI Unified Interface

WCP360 is controlled via a single, statically compiled Go binary. The command `wcp` (symlink to `/opt/wcp360/bin/wcp360`) provides a hierarchical CLI designed for speed, security, and automation.

## 🚀 Core Service Lifecycle
Management of the `wcpd` system daemon.

| Command | Description |
| :--- | :--- |
| `wcp start` | Initialise and start the core daemon. |
| `wcp stop` | Graceful shutdown of all services and loops. |
| `wcp restart` | Full service cycle (Stop -> Start). |
| `wcp reload` | Hot-reload configurations without dropping connections. |
| `wcp status` | Real-time status of the daemon and worker pools. |
| `wcp health` | Deep diagnostic of kernel requirements (PSI, cgroups). |

---

## ⚙️ Configuration & Diagnostics
Management of `/etc/wcp360/` and system health.

| Command | Description |
| :--- | :--- |
| `wcp config show` | Display active configuration (merging YAML + Defaults). |
| `wcp config set <k> <v>` | Update a specific configuration key. |
| `wcp config validate` | Check syntax and logic of configuration files. |
| `wcp doctor` | Run full system check (Permissions, Ports, Kernel). |
| `wcp logs` | Stream consolidated `zap` structured logs. |
| `wcp audit` | Search and export signed audit trails. |

---

## 👤 User & Account Management (RBAC & Isolation)
Orchestration of hosting environments and systemd-slices.

### User Lifecycle
* `wcp user create` : Provision new user, `/srv/www/` root, and cgroup.
* `wcp user delete` : Atomic wipe of user data and system presence.
* `wcp user suspend` / `unsuspend` : Freeze/Thaw user processes via cgroup signals.
* `wcp user set-quota` : Define hard/elastic limits for CPU, RAM, and Disk.

### RBAC & Resellers
* `wcp role [create|assign|permissions]` : Manage fine-grained access.
* `wcp reseller [create|delete|set-limits]` : Manage sub-account environments.



---

## 🌐 Domain & Network Services
Managing the `wcp-gateway` and connectivity.

### Domains & SSL
* `wcp domain [add|remove|list]` : Manage virtual hosts and proxy routes.
* `wcp ssl [issue|renew|revoke]` : Full ACME / Let's Encrypt automation.

### DNS (Local or Remote)
* `wcp dns [add|delete|list]` : Manage records (Native or Cloudflare/PowerDNS).

---

## 🗄️ Database Management
Engines supported: **MariaDB**, **PostgreSQL**.

* `wcp db [create|delete|list]` : Manage database instances.
* `wcp db user [create|grant]` : Database-level user permissions.
* `wcp db [backup|restore]` : Dump and import tools.

---

## 📬 Email Infrastructure
* `wcp mail [create|delete|list]` : Mailbox management.
* `wcp mail [password|forward]` : Settings and aliases.
* `wcp mail autoresponder` : Sieve-based automated replies.

---

## 📦 Backup Management
Supports: **Local**, **S3-Compatible**, **Incremental**.

* `wcp backup create` : Snapshot website + DB + Meta.
* `wcp backup schedule` : Setup CRON-based automated backups.
* `wcp backup verify` : Check integrity of stored archives.

---

## 🌍 Web Server Module
Features: **Nginx Dynamic Generation**, **Multi-PHP-FPM**, **HTTP/3**.

* `wcp webserver [enable|disable]` : Manage the web serving layer.
* `wcp webserver reload` : Apply new vhost configs safely.
* `wcp webserver test-config` : Dry-run for Nginx/Proxy configurations.

---

## 🔐 Security & Monitoring
* `wcp security 2fa [enable|status]` : Multi-factor for Admin/User.
* `wcp security firewall rules` : Manage NFTables rules.
* `wcp security waf [enable|disable]` : ModSecurity / Rate-limiting control.
* `wcp metrics show` : Real-time resource usage (Exportable to Prometheus).



---

## 🔌 Module & Cluster (Future-Proofing)
* `wcp module [install|enable|list]` : Extend WCP360 with plugins.
* `wcp cluster [init|join|leave]` : Transform to multi-node architecture.

---

## 🚀 Technical Bootstrap (Bash)
