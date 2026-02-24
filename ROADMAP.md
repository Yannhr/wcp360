# WCP360 Roadmap

This roadmap outlines the planned development phases for **WCP360** — a modern, API-first, multi-tenant hosting control platform built in Go.

The project is currently in **early alpha stage** (as of February 2026): strong focus on architecture, documentation, installation foundation, and modular design. No production-ready features yet, but the foundation is being laid for rapid iteration.

We aim for a **minimal viable product (MVP)** that demonstrates core multi-tenant isolation, automated provisioning, and basic hosting capabilities within 2026.

## Guiding Principles
- Core remains immutable and non-pluggable
- Security centralized (never delegated to modules)
- Strict tenant isolation (RBAC + cgroups v2 + namespaces)
- API as single source of truth
- Idempotent, asynchronous operations via job engine
- Extensibility via modules without compromising guarantees

## 2026 Roadmap – High-Level Phases

### Phase 0: Foundation & Bootstrap (Q1 2026 – Current)
**Status: In progress / Mostly done**

- [x] Repository setup & governance files (LICENSE AGPLv3, CONTRIBUTING, CODE_OF_CONDUCT, SECURITY.md)
- [x] Detailed ARCHITECTURE.md with principles, invariants, module contract
- [x] Documentation suite: FEATURES.md, HARDENING.md, INSTALLATIONINSTRUCTION.md
- [x] One-click install script skeleton (`install-wcp360.sh`)
- [x] Docker Compose for dev environment
- [x] First-boot architecture (PAM root bootstrap, auto-admin, system_initialized flag)
- [ ] Secure bootstrap implementation (core/bootstrap package)
- [ ] Minimal CLI commands (`wcp360 setup`, `wcp360 admin create`)

**Milestone goal**: A fresh server can run the installer and reach a "initialized but empty" state.

### Phase 1: Core Engine MVP (Q1–Q2 2026)
**Status: Planning / Early implementation**

- Job engine (Asynq/Redis-based, idempotent tasks, retries, scheduling)
- Centralized audit logging (append-only, immutable)
- Tenant lifecycle + strict context propagation
- RBAC + permission matrix enforcement
- Resource governance (quotas via cgroups v2 + systemd slices)
- API v0 (health endpoints, basic CRUD for tenants/users)
- System state persistence & reconciliation basics

**Milestone goal**: Core can enqueue jobs, enforce policies, and log actions without modules.

### Phase 2: First Functional Modules & Provisioning (Q2–Q3 2026)
**Status: Planned**

- **Web Server Module** (Nginx): vhost generation, templates, graceful reload, zero-downtime
- **SSL Module** (ACME v2 / Let's Encrypt): auto-issuance, renewal jobs, cert management
- **Database Module** (PostgreSQL/MariaDB): DB/user provisioning, privileges, backups hook
- Basic demo/quick-start: auto-provision default hosting package on first-boot
- WebSocket real-time (job progress, logs, metrics)

**Milestone goal**: A user can create a domain → get auto-HTTPS site with basic hosting (static or PHP).

### Phase 3: Essential Hosting Features & UI Alpha (Q3–Q4 2026)
**Status: Planned**

- Email Module (Postfix/Dovecot/Rspamd basics)
- Backup Module (incremental, S3/local)
- DNS Module (PowerDNS or API drivers)
- Admin UI (React/Vite + shadcn/ui): login, dashboard, tenant management
- Client UI basics (wpanel): domain list, resource usage
- CLI full mirroring of key API endpoints
- Rate limiting, 2FA/WebAuthn enforcement

**Milestone goal**: Resellers can manage tenants; clients can self-serve basic hosting.

### Phase 4: Stability, Security & Extensibility (Q4 2026 – 2027)
**Status: Future**

- API v1 stable + OpenAPI spec + SDKs (Go, JS/TS)
- Plugin registry (public module hub)
- Advanced isolation (AppArmor/SELinux profiles, network namespaces)
- Monitoring integration (Prometheus metrics, alerts)
- Cluster mode beta (multi-server federation)
- Public beta release + community modules

**Milestone goal**: Production-viable for small VPS providers or agencies.

## Longer-Term Vision (2027+)
- Full reconciliation loop (desired vs actual state)
- Energy/CO₂ tracking for green hosting
- Multi-cloud drivers (AWS, Hetzner, DigitalOcean APIs)
- Mobile app / progressive web app
- Enterprise features (LDAP/SSO, audit export, compliance reports)

## Current Priorities (February 2026)
1. Finish first-boot bootstrap (PAM + auto-admin + demo package)
2. Implement job engine + audit logging
3. Build Webserver + SSL modules first
4. Add GitHub Actions CI (lint, test, docker build)
5. Publish curl | bash installer

Contributions are welcome — start with docs, tests, or small modules!

See also: [ARCHITECTURE.md](ARCHITECTURE.md) | [FEATURES.md](FEATURES.md) | [INSTALLATIONINSTRUCTION.md](INSTALLATIONINSTRUCTION.md)
