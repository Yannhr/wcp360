# 🏗 WCP360 Architecture Overview

WCP360 is a modular, API-first, multi-tenant web control panel built with Go.

It is designed around clear separation of concerns:

- Frontend (Admin & Client)
- REST API + WebSocket layer
- Core Engine
- Modular service layer
- Underlying system services (Nginx, DB, Mail, etc.)

---

# 1️⃣ High-Level Architecture

    A[wcpanel / wpanel] --> B[REST API + WebSocket]
    B --> C[Core Engine]
    C --> D[Modules Layer]
    D --> E[System Services]

---

# 2️⃣ Repository Structure

cmd/
  wcpd/              → Main daemon entrypoint
  wcp-cli/           → CLI interface

core/
  auth/              → Authentication logic
  user/              → User lifecycle management
  domain/            → Domain provisioning
  quota/             → Resource limits
  security/          → Security policies
  events/            → Internal event bus
  config/            → Configuration loader

api/
  handlers/          → REST handlers
  middleware/        → Auth, rate limit, logging
  routes/            → Route definitions
  websocket/         → Real-time communication

modules/
  webserver/         → Nginx automation
  database/          → MariaDB / PostgreSQL
  email/             → Mail services
  backup/            → Backup system
  dns/               → DNS integration

frontend/
  wcpanel/           → Admin / reseller UI
  wpanel/            → Client UI

---

# 3️⃣ Core Components

## 🧠 Core Engine

Responsible for:

- User lifecycle management
- Domain provisioning
- Quota enforcement
- Security enforcement
- Event dispatching
- Configuration management

The core remains independent from UI logic.

---

## 🌐 API Layer

- Versioned endpoints (/api/v1)
- JSON-based responses
- WebSocket support for real-time updates
- Middleware stack:
  - Authentication
  - RBAC enforcement
  - Rate limiting
  - Logging
  - Input validation

The CLI mirrors this API layer.

---

## 🔌 Module System

Modules follow a standardized lifecycle:

- Install()
- Enable()
- Disable()
- Remove()
- Status()

## Typical Modules Example :

# 🌐 Web Server Module
Virtual host generation
Safe config validation
Zero-downtime reload
Per-tenant service isolation

# 🗄 Database Module
Database provisioning
User management
Privilege enforcement
Backup integration

# 📬 Email Module
Mailbox provisioning
Domain mail routing
Account-level isolation

# 📦 Backup Module
Incremental backups
Local and object storage
Restore validation

# 🌍 DNS Module
DNS record management
Per-domain isolation

# 🔐 SSL Module
Certificate issuance
Renewal
Revocation
Modules operate through the core engine.

---

# 4️⃣ Frontend Architecture

## 🖥 wcpanel/ (Admin / Reseller Interface)

The `wcpanel/` application is the administrative control interface of WCP360.

It is designed for:

- Root administrators
- Infrastructure operators
- Hosting providers :
# 📦 Hosting Package Management (Admin / Reseller)

The `wcpanel/` interface provides a full hosting package system.

Hosting packages define resource limits, enabled features, and policies applied to accounts.

They are the foundation of scalable multi-tenant hosting.

---

## 🧩 Package Creation

Administrators and resellers can create hosting packages that define:

- Package name
- Package description
- Target user tier (admin / reseller / client)
- Visibility scope (global or reseller-specific)

---

## 📊 Resource Limits Per Package

Each package can define strict resource constraints:

### System Resources

- CPU limit (percentage or core allocation)
- Memory limit
- Disk space quota
- Inode limit
- Bandwidth limit
- Concurrent process limit

### Service Limits

- Number of domains
- Number of subdomains
- Number of databases
- Number of database users
- Number of email accounts
- Number of FTP accounts
- Number of cron jobs

---

## 🔌 Feature Flags

Packages can enable or disable features:

- SSH access
- Cron job management
- Git deployment
- Staging environments
- SSL management
- DNS management
- Backup access
- API access
- Node/Python support (future)
- Custom PHP configuration
- Advanced logs access

---

## 🗄 Storage Configuration

Package-level storage options:

- Local disk storage
- Network storage (NFS)
- Object storage (S3-compatible)
- Snapshot support (enabled / disabled)

---

## 🔐 Security Policies

Each package can define:

- Optional or mandatory 2FA
- API rate limiting tier
- Max concurrent sessions
- Allowed IP restrictions
- Upload size limits
- Process execution restrictions

---

## 📈 Resource Enforcement

The Core Platform enforces package policies:

- Quotas are enforced at system level
- Feature flags are validated at API level
- Limits are checked before provisioning
- Overuse detection triggers alerts or suspension (optional)

---

## 👥 Package Assignment

Accounts must be assigned a package at creation.

Admins can:

- Change account package
- Upgrade/downgrade package
- Suspend accounts exceeding limits
- Apply bulk package changes

---

## 🏢 Reseller Package Management

Resellers can:

- Create packages within admin-defined limits
- Assign packages to their clients
- Override limited resource values (within allowed range)
- Monitor usage of their packages

Admin can define:

- Maximum number of packages per reseller
- Maximum aggregate resources per reseller

---

## 📊 Usage Monitoring Per Package

The system provides:

- Package-level usage statistics
- Aggregate consumption overview
- Over-limit alerts
- Historical usage tracking

---

## 🔄 Package Templates & Versioning (Advanced)

Optional future capabilities:

- Versioned package definitions
- Package inheritance
- Default system packages
- Automatic policy propagation
- Package cloning

---

## 🎯 Design Objectives

The hosting package system must:

- Be enforced centrally by Core
- Prevent resource over-allocation
- Support reseller hierarchies
- Enable scalable hosting models
- Provide predictable resource behavior
- Support future billing integration

---

Hosting packages are the economic and technical foundation of WCP360's multi-tenant architecture.

---

It provides full server-wide control, policy enforcement, and multi-tenant orchestration.

All operations are governed by Core security and RBAC policies.

---

# 🌍 Global Dashboard

Comprehensive system overview:

- Total accounts & resellers
- Active domains
- Resource utilization (CPU, RAM, Disk, Bandwidth)
- Service status (Web, DB, Mail, DNS)
- Node health (future cluster mode)
- Active alerts & incidents
- Background task overview
- Recent audit events

Real-time updates via WebSocket.

---

# 👤 Account & Tenant Management

Full multi-tenant lifecycle control:

- Create / suspend / delete accounts
- Create / suspend / delete package (storage, f
- Restore suspended accounts
- Reset passwords
- Assign ownership (reseller mapping)
- Transfer accounts between resellers
- Bulk operations (batch actions)
- Account cloning
- Account suspension policies

---

# 📊 Resource Governance & Isolation

Granular resource control per tenant:

- CPU quota limits
- Memory limits
- Disk quotas
- Bandwidth limits
- Soft vs hard limits
- Per-user PHP-FPM pools
- Per-user service isolation
- API rate limiting per tenant
- Storage driver abstraction:
  - Local storage
  - Network storage (NFS)
  - Object storage (S3-compatible)

---

# 🔌 Module & Service Management

Centralized infrastructure orchestration:

- Install / enable / disable modules
- Module version tracking
- Safe module updates
- Dependency validation
- Service restart control
- Service reload validation
- Module health status
- Plugin registry (future)

---

# 🔐 Security & Compliance Controls

Enterprise-grade security management:

- Global RBAC configuration
- Optional 2FA enforcement policies
- IP allowlists / deny lists
- Rate limiting configuration
- WAF management (if enabled)
- Brute-force protection settings
- Login anomaly detection
- Audit log integrity hashing
- Immutable audit storage design
- Security event monitoring

---

# 📈 System Monitoring & Observability

Full system visibility:

- Real-time service monitoring
- Resource consumption per tenant
- Service-level logs viewer
- Prometheus metrics overview
- Alert configuration & management
- Health endpoint status
- Node monitoring (cluster-ready)

---

# 🔄 Migration & Portability

Designed to simplify onboarding:

- Migration tool (legacy panel → WCP360)
- Account import automation
- Database import support
- Mailbox migration
- Configuration compatibility validation

---

# 🧬 Advanced Account Features

Modern hosting provider capabilities:

- Snapshot system (point-in-time account state)
- Staging environment creation
- Environment promotion (staging → production)
- Git deployment integration
- Per-user PHP version switching
- Application restart controls
- Environment variable management
- Cron job management (per tenant)

---

# 🛡 Malware & Integrity Controls

- Malware scanner integration
- Scheduled scan policies
- File integrity monitoring
- Automatic quarantine (optional)
- Auto-healing services (restart crashed services)
- Drift detection & reconciliation

---

# 🔗 Automation & Integration

Designed for hosting provider ecosystems:

- Webhooks system (events → external systems)
- API key management
- API usage analytics
- External billing integration hooks
- Event-driven automation

---

# 🗄 Backup & Recovery Management

Admin-level oversight:

- Global backup policy configuration
- Backup retention policies
- Storage backend configuration
- Backup verification
- Disaster recovery workflow
- Partial or full restore controls

---

# 🏗 Reseller Management

Multi-tier hosting support:

- Create / manage resellers
- Set reseller limits
- Track reseller usage
- Assign reseller-specific quotas
- Branding controls (future)
- Usage reporting

---

# 🧠 Reliability & Safety Controls

Platform-level safeguards:

- Zero-downtime service reload
- Configuration validation before apply
- Transactional provisioning
- Job retry policies
- Failed task recovery interface
- System "maintenance mode"

---

# 📜 Audit & Transparency

Full administrative accountability:

- Server-wide audit log viewer
- Tenant-specific audit drill-down
- Event filtering & search
- Integrity hashing verification
- Export audit logs

---

# 🎯 Design Objectives

The `wcpanel/` interface must:

- Be powerful yet controlled
- Enforce strict security boundaries
- Provide full observability
- Support hosting-provider scale
- Enable automation
- Be cluster-ready
- Prevent unsafe operations by design

The Admin / Reseller panel acts as the operational control center of WCP360, enabling reliable, scalable, and secure multi-tenant hosting management.

---

## 👤 wpanel/ (Client Interface)

The `wpanel/` application is the end-user (tenant) interface.

It provides a fully isolated, self-service control environment where users can manage only their own resources.

All actions are strictly scoped to the authenticated tenant.

---

## 🏠 Personal Dashboard

The dashboard provides a real-time overview of the account:

- Resource usage summary (CPU, RAM, Disk, Bandwidth)
- Active domains
- Active databases
- Email accounts count
- Backup status
- SSL certificate status
- System notifications
- Pending tasks (provisioning, backups, SSL issuance)
- Recent activity log (user-scoped audit events)

---

## 🌐 Domain Management

Users can manage their domains and subdomains:

- Add / remove domains
- Add / remove subdomains
- Domain suspension (if allowed by policy)
- Document root configuration
- PHP version selection (per-domain)
- Redirect rules (HTTP → HTTPS, domain forwarding)
- Access log & error log viewer
- Per-domain configuration overview

---

## 🌍 DNS Management

If DNS module is enabled:

- Manage DNS zones
- Add / edit / delete records:
  - A
  - AAAA
  - CNAME
  - MX
  - TXT
  - SRV
- TTL configuration
- DNS templates (if enabled)
- Validation warnings for unsafe records

---

## 📂 File Manager

Secure browser-based file management:

- Upload / download files
- Drag-and-drop support
- Folder creation
- File editing (code editor with syntax highlight)
- Rename / move / delete
- Permissions (chmod)
- Archive / extract (zip, tar)
- Disk usage overview
- Safe path validation (no directory traversal)

Optional future:

- Git deployment integration
- SFTP credential management

---

## 🗄 Database Management

Full database control within tenant scope:

- Create / delete databases
- Create / delete database users
- Assign privileges
- Password rotation
- Import / export SQL dumps
- Connection information display
- Database usage overview
- Backup integration

Supported engines:

- MariaDB
- PostgreSQL

---

## 📬 Email Management

Per-domain mail configuration:

- Create / delete mailboxes
- Reset mailbox password
- Forwarders
- Auto-responders
- Mailbox storage usage
- Mail routing configuration (local/remote)
- Spam filter settings (if enabled)
- DKIM/SPF configuration visibility

---

## 🔐 SSL & Certificate Management

- Issue Let's Encrypt certificates
- Renew certificates
- Revoke certificates
- Upload custom certificates
- Certificate status monitoring
- Auto-renewal tracking
- HTTPS enforcement toggle

---

## 📦 Backup Management

- On-demand backups
- Scheduled backups (if allowed)
- View available backups
- Restore full account
- Restore partial resources:
  - Files only
  - Databases only
  - Emails only
- Backup storage location display
- Backup verification status

---

## 📈 Resource Monitoring

Real-time and historical metrics:

- CPU usage graph
- Memory usage graph
- Disk usage graph
- Bandwidth usage graph
- I/O statistics
- Historical trends (day/week/month)

---

## 🧾 Task & Job Viewer

Users can track background operations:

- Provisioning progress
- Backup progress
- SSL issuance
- Restore operations
- Job status (pending, running, completed, failed)
- Error reporting

---

## 🔑 Account & Security Settings

- Change account password
- Manage API tokens (if enabled)
- Optional 2FA enable/disable
- Active session management
- Login history (basic)
- SSH key management (if enabled)

---

## 🔌 Application & Environment Settings (Optional Advanced)

- PHP configuration overrides (memory_limit, upload_max_filesize)
- Environment variables
- Cron job management
- Node/Python version selection (future)
- Application restart control (if allowed)

---

## 🛡 Tenant Isolation Guarantees

The client panel enforces:

- No visibility into other tenants
- No access to server-wide settings
- Strict resource scoping
- API permission validation per request
- File system sandboxing

---

## 🎯 Design Objectives

The client interface must be:

- Fast and responsive
- Clear and non-technical for end users
- Secure by default
- Real-time when needed
- Strictly isolated
- Fully API-driven

---

The `wpanel/` interface provides everything required for a self-service hosting environment while maintaining strict separation from administrative capabilities.

Both frontends:

- Built with TypeScript
- React / Next.js
- Consume the same REST API
- Use WebSocket for real-time updates
- Share authentication/session model

---

# 5️⃣ Authentication & RBAC Model

User types:

- Root
- Admin
- Reseller
- Client
- API Token

RBAC ensures:

- Scoped module access
- Tenant isolation
- Command authorization
- API permission control

2FA is optional but supported.

---

# 6️⃣ Event-Driven Design

- Internal event dispatcher
- Optional Redis pub/sub
- Background workers for long-running tasks
- Job queue for async provisioning

Example:

User created → filesystem setup → DB provisioning → event log

---

# 7️⃣ Security Model

- No-root execution
- Per-tenant isolation
- Append-only audit logs
- Rate limiting
- Secure token handling
- Input validation
- Optional WAF integration

Security enforcement happens server-side only.

---

# 8️⃣ Scalability Strategy

- Stateless API layer
- External database backend
- Redis for events & caching
- Horizontal scaling planned
- Cluster mode (future)

---

# 9️⃣ Observability & Monitoring

- Structured JSON logging
- Health endpoints
- Prometheus-ready metrics
- WebSocket event streaming
- Future distributed tracing

---

# 🔟 CLI Integration

The \`wcp360\` CLI:

- Maps 1:1 to API endpoints
- Supports JSON output
- Designed for automation
- Includes dry-run & verbose modes

CLI is a client of the API, not a bypass mechanism.

---

# 11 Architectural Invariants

- The following rules must never be broken:
- Core never depends on modules.
- Modules cannot bypass Core security.
- All actions are tenant-scoped.
- Audit logging is centralized.
- API is the single source of truth.
- Authorization happens before infrastructure changes.
- Long tasks run through the job engine.

---

WCP360 is designed to evolve into a scalable, secure, enterprise-ready infrastructure management platform.
EOF
