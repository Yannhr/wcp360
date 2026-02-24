# ⚙️ WCP360 CLI Command Reference

The `wcp360` CLI is the official command-line interface for managing WCP360.

It provides full control over:

- Core system
- Users & tenants
- Domains
- Databases
- Email
- Backups
- Modules
- Security
- Monitoring
- Cluster (future)

The CLI is designed as a thin wrapper over the REST API and follows a modular structure.

---

# 🧠 Core System Commands

## Service Management

```bash
wcp360 start
wcp360 stop
wcp360 restart
wcp360 reload
wcp360 status
wcp360 health
Configuration
wcp360 config show
wcp360 config set <key> <value>
wcp360 config validate
wcp360 config reload
Diagnostics
wcp360 doctor
wcp360 logs
wcp360 metrics
wcp360 audit
👤 User & Account Management
User Lifecycle
wcp360 user create
wcp360 user delete
wcp360 user suspend
wcp360 user unsuspend
wcp360 user reset-password
wcp360 user set-quota
wcp360 user info
wcp360 user list
Role & Permissions (RBAC)
wcp360 role create
wcp360 role delete
wcp360 role assign
wcp360 role permissions
Reseller Management
wcp360 reseller create
wcp360 reseller delete
wcp360 reseller usage
wcp360 reseller set-limits
🌐 Domain Management
wcp360 domain add
wcp360 domain remove
wcp360 domain suspend
wcp360 domain unsuspend
wcp360 domain list
DNS
wcp360 dns list <domain>
wcp360 dns add <domain>
wcp360 dns delete <domain>
SSL
wcp360 ssl issue <domain>
wcp360 ssl renew <domain>
wcp360 ssl revoke <domain>
🗄 Database Management
wcp360 db create
wcp360 db delete
wcp360 db list
wcp360 db user create
wcp360 db user delete
wcp360 db user grant
wcp360 db backup
wcp360 db restore

Supported engines:

MariaDB

PostgreSQL

📬 Email Management
wcp360 mail create
wcp360 mail delete
wcp360 mail password
wcp360 mail forward
wcp360 mail autoresponder
wcp360 mail list
📦 Backup Management
wcp360 backup create
wcp360 backup list
wcp360 backup restore
wcp360 backup delete
wcp360 backup schedule
wcp360 backup verify

Supports:

Local storage

S3-compatible storage

Incremental backups

🌍 Web Server Module
wcp360 webserver enable
wcp360 webserver disable
wcp360 webserver reload
wcp360 webserver test-config
wcp360 webserver status

Features:

Dynamic Nginx config generation

Safe reload mechanism

Multi-PHP-FPM pools

HTTP/2 & HTTP/3 support

🔐 Security Commands
2FA (Optional)
wcp360 security 2fa enable
wcp360 security 2fa disable
wcp360 security 2fa status
WAF & Protection
wcp360 security waf enable
wcp360 security waf disable
wcp360 security rate-limit set
wcp360 security firewall rules
wcp360 security scan
📊 Monitoring & Metrics
wcp360 metrics show
wcp360 metrics export
wcp360 alerts list
wcp360 alerts acknowledge
wcp360 system status
🔌 Module Management
wcp360 module install
wcp360 module enable
wcp360 module disable
wcp360 module remove
wcp360 module list
wcp360 module update

Modules may include:

Web server

Database

Email

Backup

DNS

Future marketplace plugins

🧱 Cluster Management (Future)
wcp360 cluster init
wcp360 cluster join
wcp360 cluster leave
wcp360 cluster status
wcp360 cluster remove-node
🖥 Relationship With Web Interfaces
wcpanel/ (Admin / Reseller)

Maps to:

user

reseller

module

webserver

security

cluster

Global metrics

wpanel/ (Client)

Maps to:

domain

dns

db

mail

backup

ssl

Personal metrics

🧰 Global Flags
--json        Output in JSON format
--verbose     Enable verbose logging
--debug       Enable debug mode
--dry-run     Simulate action
--config      Specify config file

Example:

wcp360 user create --json --dry-run
🧠 Design Philosophy

CLI mirrors API structure

Every command maps to an API endpoint

Consistent naming conventions

Modular subcommand architecture

Safe-by-default behavior

Optional 2FA (configurable per user or global)