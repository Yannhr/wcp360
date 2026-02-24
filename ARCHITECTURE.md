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

Example modules:

- Web server (Nginx-first)
- Database (MariaDB, PostgreSQL)
- Email (Postfix, Dovecot)
- Backup (Restic-based)
- DNS (PowerDNS/BIND)

Modules operate through the core engine.

---

# 4️⃣ Frontend Architecture

## 🖥 wcpanel/ (Admin / Reseller)

- Global dashboard
- Account management
- Resource control
- Module management
- Security configuration
- System monitoring
- Migration tool (cPanel → WCP360)
- Account cloning
- Snapshot system
- Per-user PHP version switching
- Cron job management
- Git deployment integration
- Staging environments
- Malware scanner
- Auto-healing services
- Webhooks system
- API rate limiting per tenant
- Storage driver abstraction (local / object / NFS)
- Audit log integrity hashing

## 👤 wpanel/ (Client)

- Personal dashboard
- Domain management
- File manager
- Database management
- Email management
- SSL & backups

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

# 🎯 Architectural Principles

- Modular design
- Secure-by-default
- API-first
- Multi-tenant isolation
- Clear separation between core and modules
- Observable system behavior
- Automation-ready

---

WCP360 is designed to evolve into a scalable, secure, enterprise-ready infrastructure management platform.
EOF
