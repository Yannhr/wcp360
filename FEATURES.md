# 🚀 WCP360 — Feature Overview

WCP360 is a modern, modular, API-first web hosting control panel built with Go and a TypeScript frontend.

It is designed as a secure, extensible, multi-tenant alternative to legacy control panels.

The platform is divided into two main interfaces:

- `wcpanel/` → Admin / Reseller interface (WHM-like)
- `wpanel/` → Client / End-user interface (cPanel-like)

Both interfaces share the same backend core and API layer.

---

# 🧠 Core Platform Features

## 🔹 API-First Architecture

- Versioned REST API (`/api/v1`)
- WebSocket real-time events
- Structured JSON responses
- Modular service architecture
- CLI fully mapped to API

## 🔹 Multi-Tenant Engine

- Per-account isolation
- Resource quotas (CPU, RAM, Disk, Bandwidth)
- Filesystem separation
- Service pool separation
- Scoped permissions enforcement

## 🔹 Role-Based Access Control (RBAC)

- Root
- Admin
- Reseller
- Client
- API token roles

Fine-grained permission matrix for modules and resources.

---

# 🖥 wcpanel/ — Admin / Reseller Features

## 🌍 Global Dashboard

- Server health overview
- Active services monitoring
- Account statistics
- Resource usage summary
- System alerts

## 👤 Account Management

- Create / edit / delete users
- Suspend / unsuspend accounts
- Assign quotas
- Assign roles
- Bulk operations
- Reseller account limits

## 🔧 Module Management

- Install / enable / disable modules
- Version tracking
- Update modules
- Future marketplace support

## 🌐 Web Server Control

- Nginx configuration generation
- Safe config validation & reload
- Multi-PHP-FPM pools
- HTTP/2 & HTTP/3 support
- Brotli compression support

## 🛡 Security Controls

- Optional 2FA per user
- Rate limiting
- WAF integration (Coraza ready)
- Audit log viewer
- Firewall rule management
- Login monitoring

## 📊 System Monitoring

- Service status (Web, DB, Mail)
- Resource graphs
- Prometheus metrics endpoint
- Logs viewer
- Alerts management

---

# 👤 wpanel/ — Client / End-User Features

## 📊 Personal Dashboard

- Account resource usage
- Active domains
- Notifications
- Task progress

## 📂 File Manager

- Upload / download files
- Folder creation
- File editing
- Permission management
- Archive extract / compress

## 🌐 Domain Management

- Add / remove domains
- Subdomains
- DNS record management:
  - A
  - AAAA
  - CNAME
  - MX
  - TXT
  - SRV

## 🔐 SSL Management

- Let's Encrypt automation
- Custom certificates
- Auto renewal
- Certificate status viewer

## 🗄 Database Management

- Create / delete databases
- Manage DB users
- Grant privileges
- Import / export SQL
- MariaDB support
- PostgreSQL support

## 📬 Email Management

- Create mailboxes
- Delete mailboxes
- Forwarders
- Auto responders
- Password reset

## 📦 Backup System

- On-demand backups
- Scheduled backups
- Local storage
- S3-compatible storage
- Restore functionality

## 📈 Resource Monitoring

- CPU usage graph
- Memory usage graph
- Disk usage graph
- Bandwidth usage graph
- Historical trends

---

# 🔐 Security Features

- Optional 2FA (TOTP support planned)
- Secure session handling
- API token authentication
- Audit logging (append-only design)
- Rate limiting
- Brute-force detection (planned)
- No-root execution model
- Systemd service hardening

---

# 📦 Module System

WCP360 supports a modular architecture.

Planned modules:

- Web server (Nginx-first)
- Database (MariaDB, PostgreSQL)
- Email (Postfix, Dovecot)
- Backup (Restic-based)
- DNS (PowerDNS/BIND)
- Future plugin marketplace

Modules support:

- Install
- Enable
- Disable
- Remove
- Update lifecycle

---

# 📡 Real-Time Capabilities

WebSockets enable:

- Live metrics streaming
- Task progress updates
- System alerts
- Service state changes

---

# 🧰 CLI Integration

The `wcp360` CLI mirrors API functionality:

- User management
- Domain management
- Database management
- Backup operations
- Module control
- Security configuration

Automation-ready and script-friendly.

---

# 📊 Observability & Logging

- Structured JSON logs
- Log levels (INFO, WARN, ERROR, DEBUG)
- Prometheus metrics endpoint
- Grafana dashboard compatibility
- Audit trail per user

---

# 📦 Deployment Options

- Native Go binary
- Docker container
- DEB / RPM packages (planned)
- One-line installer script
- Auto-update mechanism (planned)

---

# 🎯 Design Principles

- Security-first approach
- Clean modular architecture
- Strict tenant isolation
- API-driven design
- Automation-ready CLI
- Modern UI stack (TypeScript + React)
- Performance & scalability focused

---

WCP360 aims to become a secure, extensible, high-performance open-source hosting control panel built for modern infrastructure.