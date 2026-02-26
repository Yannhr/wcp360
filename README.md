# 🚀 WCP360  
### The Next-Generation Linux-Native Web Control Platform

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Early%20Alpha-orange)](https://github.com/Webcontrolpanel360/wcp360)
[![Platform](https://img.shields.io/badge/Platform-Debian%20%7C%20Ubuntu-green)](https://github.com/Webcontrolpanel360/wcp360)
[![Architecture](https://img.shields.io/badge/Architecture-Linux--native-black)](ARCHITECTURE.md)
[![Modular](https://img.shields.io/badge/Modular-Yes-success)](ARCHITECTURE.md)
[![GitHub stars](https://img.shields.io/github/stars/Webcontrolpanel360/wcp360?style=social)](https://github.com/Webcontrolpanel360/wcp360/stargazers)

---

## 🌍 What is WCP360?

**WCP360** is a **modern, Linux-native infrastructure control platform** built from scratch to replace legacy panels like cPanel/WHM.

It delivers:
- **Blazing performance** — pure Go backend, Nginx-native, event-driven
- **Rock-solid security** — zero-trust, immutable core, strong tenant isolation (cgroups v2)
- **True modularity** — install only what you need, extend anything
- **Minimal footprint** — runs efficiently on VPS, dedicated servers, and cloud
- **Future-proof design** — API-first, cluster-ready, IaC compatible

WCP360 is **not** just another hosting panel — it's a **high-precision control plane** for serious operators who demand speed, security, and extensibility without legacy bloat.

### Licensing & Editions

- **Open-Source Core** — MIT License  
  Free forever for personal use, development, and production.  
  Full source code, modules, and community contributions welcome.


---

### 🗺️ Explore the Project

| Resource | Description |
| :--- | :--- |
| 🛤️ **[Roadmap](ROADMAP.md)** | Our vision for future releases and cloud scaling. |
| 🏗️ **[Architecture](ARCHITECTURE.md)** | Core invariants, internal logic, and design patterns. |
| 🧩 **[Features](FEATURES.md)** | A deep dive into built-in capabilities and modules. |
| 🚀 **[Installation](INSTALLATION_INSTRUCTION.md)** | Quick-start guide and system requirements. |
| 🛡️ **[Hardening](HARDENING.md)** | Best practices for securing your production environment. |

---

# 💎 Core Pillars

WCP360 is built on four uncompromising pillars that make it faster, safer, and more future-proof than legacy control panels.

- **⚡ Performance-First**  
  Event-driven Go core + Nginx-native stack → sub-second responses, ultra-low overhead, and high tenant density even on modest VPS.

- **🔐 Security by Design**  
  Zero-trust architecture with centralized enforcement, immutable audit trail, rootless runtime after bootstrap, and strict tenant isolation via cgroups v2 + namespaces.

- **🧩 Modular Agility**  
  Lean, immutable core + hot-swappable modules → install only what you need today, extend tomorrow without touching the foundation.

- **🐧 Linux-Native**  
  No heavy abstractions, no Perl/PHP bloat — direct integration with systemd, cgroups v2, nftables, and kernel primitives for maximum efficiency and control.

These pillars are **non-negotiable invariants** — not optional features.

# 🚀 Built For Modern Workloads

WCP360 is engineered from the ground up for today's (and tomorrow's) real hosting realities:

- **Hosting Management**  
  Fully automated domain, SSL (ACME v2), multi-PHP pools, and tenant lifecycle — no manual scripting or legacy rebuilds.

- **Server Administration**  
  Deep system visibility and control (resource governance, process isolation, audit logs) directly in the platform — no SSH roulette.

- **Infrastructure Control**  
  Granular per-tenant quotas, cgroup slicing, and runtime enforcement — prevent abuse, crashes, and noisy neighbors.

- **Cloud & Scalability Ready**  
  API-first design + cluster-ready foundation (v2.0+) — start on a single VPS, grow to multi-node orchestration without rewriting your stack.

> [!TIP]  
> WCP360 is **not cPanel/WHM with a fresh coat of paint**.  
> It is a clean-sheet, modern **infrastructure control plane** — built for operators who want performance, security, and extensibility without legacy tax.

v1.0 delivers a rock-solid single-node foundation.  
v2.0–v3.0 unlocks distributed clusters, IaC integration, and advanced orchestration.

Serious operators choose WCP360 for **precision where legacy panels fail**.

---

# 🧩 Tech Stack Overview

**Built by serious operators, for serious operators.**

WCP360 is **pure Go** at its core — no JavaScript frameworks, no Node.js runtime in the first release.  
The initial version prioritizes a **rock-solid, minimal, secure backend** before adding any web UI layer.

### ⚙ Core Layer
[![Go](https://img.shields.io/badge/Core-Go-00ADD8?logo=go&logoColor=white)](https://go.dev/)
- Single-language backend: everything in **Go 1.23+**
- Event-driven, concurrent, low-memory footprint
- Idempotent job queue (Asynq + Redis)
- Strict tenant isolation via cgroups v2 & systemd slices

### 🔐 Security Layer
[![Coraza](https://img.shields.io/badge/WAF-Coraza-red)](https://coraza.io/)
[![OWASP CRS](https://img.shields.io/badge/OWASP-CRS-critical)](https://owasp.org/www-project-modsecurity-core-rule-set/)
- Built-in WAF (Coraza + OWASP Core Rule Set auto-update)
- Append-only immutable audit trail
- Zero-trust model: no root after bootstrap
- PAM one-time bootstrap → non-root daemon
- Signed internal communication (Unix sockets or mTLS)

### 🌐 Gateway & Reverse Proxy
[![Nginx](https://img.shields.io/badge/Edge-Nginx-009639?logo=nginx&logoColor=white)](https://nginx.org/)
- Single public entry point (80/443 only)
- HTTP/3, Brotli, FastCGI caching
- Tenant-aware vhost generation
- Automatic HTTPS (ACME v2 / Let's Encrypt)

### 🗄 Data & State Layer
[![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-336791?logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Redis](https://img.shields.io/badge/Jobs+Cache-Redis-DC382D?logo=redis&logoColor=white)](https://redis.io/)
- PostgreSQL (preferred) for persistent state & audit
- Redis for job queue, caching, sessions
- Schema migrations (golang-migrate)

### 🌍 Infrastructure & Runtime
[![Systemd](https://img.shields.io/badge/Orchestration-systemd-444444)](https://systemd.io/)
[![Podman](https://img.shields.io/badge/Containers-Podman-892CA0?logo=podman&logoColor=white)](https://podman.io/)
[![Rootless](https://img.shields.io/badge/Mode-Rootless-success)]()
- Rootless Podman / Quadlet for optional containerized modules
- Native systemd integration (slices, services, timers)
- FHS-compliant layout: `/opt/wcp360`, `/etc/wcp360`, `/var/lib/wcp360`
---

## Technology Stack (as designed for v1.0 – February 2026)

| Layer                     | Main Technology                              | Primary Role                                          | Strategic Choice / Notes                                      |
|---------------------------|----------------------------------------------|-------------------------------------------------------|----------------------------------------------------------------|
| **Language & Runtime**    | Go 1.23+                                     | Core backend, API, CLI, reconciliation logic          | Single static binary • excellent concurrency • zero external runtime |
| **User Interface**        | Server-Side Rendering (Go `html/template`) + Tailwind CSS (embedded) | Admin & tenant dashboards                             | Zero client-side JavaScript → drastically reduced attack surface & fast loading |
| **Web Server (tenants)**  | Nginx (HTTP/3, QUIC, Brotli, FastCGI)        | Hosting customer websites, dynamic vhosts             | Best-in-class TLS/performance • tenant-aware config generation |
| **Panel Gateway / Proxy** | Go (Gin or chi router)                       | Public entry point (80/443), rate limiting, auth      | Fine-grained control • fast-path critical security            |
| **Cache, Sessions & Queue** | Redis + Asynq                              | Full-page cache, sessions, background jobs            | Ultra-low latency • reliable retries & priorities              |
| **Panel Database**        | PostgreSQL                                   | Persistent configuration, users, audit logs           | Strong transactions • JSONB support • reliability              |
| **Tenant Databases**      | MariaDB + PostgreSQL (auto-provisioned)      | Databases created for customer sites                  | Maximum compatibility (WordPress, Laravel, etc.)               |
| **Job Queue**             | Asynq (Redis-backed)                         | Async tasks (backups, SSL renewals, malware scans…)   | Monitoring built-in • idempotency & priority queues            |
| **Resource & Isolation**  | cgroups v2 + systemd slices + namespaces + PSI | Per-tenant CPU/RAM/IO limits & bursting               | Kernel-native • intelligent bursting • very low overhead       |
| **Web Application Firewall** | Coraza + OWASP Core Rule Set 4.x (auto-update) | Dynamic web protection                             | Advanced scoring • rules kept current                          |
| **Dynamic Firewall**      | nftables                                     | Tenant-specific rules, geo-blocking, basic anti-DDoS  | Faster & more flexible than firewalld                          |
| **SSL / Certificates**    | go-acme (Let’s Encrypt) – HTTP-01 + DNS-01   | Automatic issuance & renewal                          | Wildcard + multi-domain support                                |
| **Audit & Logging**       | Structured JSON + cryptographically signed immutable logs | Full traceability                                  | Immutable • correlation IDs • configurable retention           |
| **Extensibility**         | Go modules + future WASM plugins             | Adding features without recompiling core              | Hot-swap capability planned                                    |
| **Installation & Runtime**| Idempotent bash script + systemd             | One-command bootstrap (user, DB, secrets, services)   | Zero manual configuration after install                        |

**Core philosophy**: Go-dominant • kernel-native primitives • zero legacy bloat (no Perl/PHP/Node in the panel itself) • single-binary mindset.

----

# 🎯 Mission

WCP360 is engineered to be the **high-performance, secure, and modular infrastructure control layer** for modern hosting.

We are replacing bloated, legacy control panels with a platform that prioritizes:

- **⚡ Speed** — Optimized Go binaries + event-driven architecture  
- **🛡️ Security** — Zero-trust model + hardened kernel integration (cgroups v2, SELinux/AppArmor)  
- **🪶 Lightweight** — Minimal resource usage to maximize hardware efficiency  
- **🧩 Modular** — Install only the features you need; extend freely  
- **🐧 Linux-Native** — Direct interaction with systemd, cgroups v2, and kernel primitives  
- **☁️ Scalable** — Designed to grow from a single VPS to multi-node clusters  

> [!TIP]  
> WCP360 is **not another legacy hosting panel**.  
> It is a professional-grade **infrastructure control plane** built for serious operators who demand precision, reliability, and performance.

---

# 🧱 Target Infrastructure – Better Than cPanel/WHM

WCP360 is built to **replace legacy panels like cPanel/WHM** with a faster, lighter, more secure, and truly modern control layer — without the bloat, Perl legacy, or massive resource overhead.

It runs efficiently on **VPS**, **dedicated servers**, and **cloud instances**, with dramatically better density, performance, and security isolation.

### 🖥️ VPS & Entry-Level Servers (Ideal for Shared Hosting & Resellers)
- **Ultra-low footprint** — runs comfortably on 1–2 GB RAM VPS (vs cPanel's 4–8 GB minimum)  
- **Intelligent tenant slicing** — cgroups v2 + systemd slices guarantee fair CPU/RAM/IO (no more "noisy neighbor" crashes)  
- **High-density hosting** — 3–5× more tenants per node than cPanel/WHM without slowdowns  
- **Rootless & secure by default** — no persistent root execution, no dangerous suPHP/mod_php

### 🏢 Dedicated & Bare-Metal Servers (Enterprise & High-Performance Hosting)
- **Direct hardware optimization** — leverages full CPU cores, NVMe I/O, and RAM bandwidth  
- **Database tuned for scale** — MariaDB/PostgreSQL with huge buffers, query cache, and I/O scheduler tuning  
- **Hardware security features** — TPM 2.0 integration, Secure Boot enforcement, hardware RNG for crypto  
- **No legacy cruft** — drops Perl, PHP-based backend, old Apache dependencies — pure Go + Nginx

### ☁️ Cloud & Scalable Deployments (v2.0+ Vision – Single-Node Core First)
- **API-first from day one** — full REST/GraphQL surface for automation (Terraform, Ansible, Pulumi, Kubernetes operators)  
- **Cluster-ready foundation** — agent model + shared token/state sync (roadmap for multi-node)  
- **Horizontal scaling** — add nodes, distribute tenants, central orchestration (v3.0+)  
- **Cloud-native friendly** — rootless Podman/Quadlet support, OCI-like module packaging  

> [!IMPORTANT]  
> **v1.0 focuses on single-node perfection** — rock-solid core, strong isolation, and essential modules (web + SSL + database).  
> **Cloud/multi-node & advanced orchestration** are roadmap priorities after v1.0 stability (v2.0–v3.0).

**Why WCP360 is better than cPanel/WHM in 2026**
- 5–10× lower resource usage  
- True zero-trust & immutable audit trail  
- No Perl/PHP bloat — modern Go + Nginx stack  
- cgroups v2 isolation (not just user quotas)  
- One-click modules (no EasyApache rebuilds)  
- Designed for VPS density & cloud automation from the start  

Serious operators choose WCP360 for **precision, speed, security, and future-proofing** — not legacy tax.

---

# 🐧 Supported Operating Systems

WCP360 is built close to the Linux kernel for maximum performance and security.  
We prioritize distributions with long-term stability, enterprise hardening, and native tooling.

### 🔹 Tier 1 – Production Ready (Recommended)
- **Ubuntu LTS** (22.04, 24.04+)  
- **Debian Stable** (12 Bookworm+)  

### 🔹 Tier 2 – Enterprise / Hosting-Focused (Strong Support Planned)
- **AlmaLinux 9+** (industry standard for professional hosting)  
- **Rocky Linux 9+** (community-driven RHEL clone)  
- **CloudLinux** (advanced shared hosting isolation features)  

### 🔹 Tier 3 – Specialized / Future Support
- **Alpine Linux** (ultra-minimal containers & edge deployments)  
- **Fedora Server** (testing newer kernel features)  

> [!IMPORTANT]  
> We focus on **long-term supported** releases only.  
> Bleeding-edge or short-lifecycle distros (e.g., Arch, Gentoo) are not supported.
---

**Linux-native.** **No abstraction layers.** **No compatibility bloat.**

> [!IMPORTANT]
> **Architecture Note:** We exclusively target systems utilizing **systemd** and **cgroups v2**. This ensures native resource isolation and hardware-level performance without the overhead of third-party virtualization layers.

---

### Why these Operating Systems?
By expanding support to the **RHEL family (Alma/Rocky)**, WCP 360 positions itself as a direct, high-performance alternative to legacy proprietary panels, enabling seamless migrations for enterprise-scale infrastructures.

---

# 🏗 Architecture Overview

WCP360 is built around a **minimal, immutable core** that enforces security, isolation, and extensibility from the ground up.

## 🧠 Minimal Core (The Foundation)

The core is intentionally small, hardened, and non-negotiable:

- **Immutable** — cannot be modified or bypassed  
- **Hardened** — drops root, enforces zero-trust, central audit  
- **Event-driven** — asynchronous jobs via queue (idempotent & retryable)  
- **Fully extensible** — everything beyond basics is a pluggable module  

### Core Responsibilities (v1.0 focus)

- Multi-tenant lifecycle & strict RBAC  
- Resource governance (cgroups v2 + systemd slices)  
- Tenant-scoped API gateway  
- Centralized security enforcement (WAF rules, rate limiting, validation)  
- Job orchestration & audit trail (append-only)  
- Module loading & lifecycle management  
- Secure bootstrap (PAM root → admin auto-creation)  

**Nothing is hardcoded.**  
All hosting features (web, db, email, dns…) are external modules.

---

# 🧩 Modular Ecosystem (v1.0 & Roadmap)

Modules are **self-contained Go packages** that implement a simple interface.  
Activate only what you need — keep the attack surface and resource usage minimal.

| Icon | Module              | Purpose                          | Key Features (v1.0 focus)                     | Status (Feb 2026) |
|------|---------------------|----------------------------------|-----------------------------------------------|-------------------|
| 🌐   | **Web Server**      | Website & app hosting            | Nginx vhost generation, multi-PHP, HTTP/3, Brotli | Priority #1 – Planned |
| 🗄   | **Database**        | Database provisioning            | MariaDB / PostgreSQL, user/db creation, privileges | High – Planned    |
| 🔐   | **SSL**             | Certificate automation           | ACME v2 (Let's Encrypt), auto-renewal, Nginx reload | High – Planned    |
| 📧   | **Email**           | Mail hosting stack               | Postfix + Dovecot + Rspamd basics             | Medium – Planned  |
| 🌍   | **DNS**             | Zone & record management         | PowerDNS / Bind driver, API records           | Medium – Planned  |
| 💾   | **Backup**          | Data protection                  | Incremental backups, S3-compatible            | Medium – Planned  |
| 📊   | **Monitoring**      | Observability                    | Prometheus metrics export                     | Future            |
| 🔄   | **Git Deploy**      | Automated deployments            | Git push → build/deploy hooks                 | Future            |
| 📁   | **File Manager**    | Browser-based file access        | Editor, permissions, upload/download          | Future            |

**Third-party & custom modules**  
Anyone can build new modules (e.g. Redis, Node.js support, Cloudflare integration, Docker apps).  
→ See the simple Module interface in [ARCHITECTURE.md](ARCHITECTURE.md)

**v1.0 Goal**  
Deliver a rock-solid core + the essential trio: **Web Server + SSL + Database** — enough for real tenant websites with HTTPS auto-provisioning.


---

# 🔐 Security by Default

WCP360 adopts a **security-first mindset** where protection is centralized, mandatory, and impossible to disable or circumvent.

Security is **enforced exclusively in the core platform** — modules and users cannot override or weaken it.

### Core Security Principles
- **Zero-trust model** — assume breach; verify everything
- **Centralized enforcement** — authorization, validation, and auditing happen before any action reaches a module
- **Immutable invariants** — critical guarantees (isolation, audit, no-root) cannot be turned off
- **Principle of least privilege** — no root execution after initial bootstrap

### Active Security Mechanisms
- **Tenant & Process Isolation**  
  - Linux namespaces + cgroups v2 for CPU, memory, I/O, and PID limits  
  - Per-tenant resource quotas (hard & soft) with automatic suspension on critical exceedance  

- **Resource Governance**  
  - Real-time tracking and enforcement of CPU, RAM, disk, bandwidth  
  - Prevents resource exhaustion attacks or abuse  

- **Web Application Firewall (WAF)**  
  - Integrated ModSecurity with OWASP Core Rule Set (CRS) — auto-updated  
  - Protection against SQL injection, XSS, RCE, file inclusion, bots, etc.  
  - Tenant-aware rate limiting & IP reputation scoring  

- **Abuse Prevention Engine**  
  - Built-in detection for credential stuffing, brute-force, scanning, anomalous behavior  
  - Temporary/permanent blocks + real-time notifications  

- **Immutable & Centralized Audit Logging**  
  - Append-only trail (cannot be altered even by root)  
  - Structured JSON logs with correlation IDs and full context  
  - Long-term retention configurable  

- **Installation & Runtime Hardening**  
  - Automatic application of **SELinux / AppArmor** profiles  
  - Strict file permissions (644/755, correct ownership)  
  - Default firewall rules (nftables/firewalld)  
  - Secure secret generation (JWT keys, DB passwords, etc.)  
  - Disabling unnecessary services & ports  

### Architectural Guarantees
- **No root after bootstrap** — PAM used only once during secure first-boot  
- **Modules receive pre-authorized commands** — scoped to tenant & validated  
- **All mutations go through the job engine** — audited & asynchronous  
- **No security bypass** possible via UI, API, CLI, or custom modules  

In short: **Security is a constraint, not a choice.**  
Even a malicious admin or compromised module cannot violate the core invariants.

**Zero trust. Zero exceptions.**

---
# ⚡ Performance Philosophy

WCP360 is engineered for **maximum efficiency** and **minimal overhead** — even on modest VPS or dedicated servers.

We deliberately choose a **lean, modern, no-bloat stack** that delivers real-world results:

- **Nginx-only web stack** (no Apache legacy)  
  → Event-driven, handles thousands of concurrent connections with very low memory

- **Intelligent FastCGI caching** with automatic purge on content changes  
  → Reduces dynamic backend hits (PHP/MySQL) by 5–10× on average

- **Redis object caching** (full-page, transients, sessions, queries)  
  → Sub-50 ms response times under moderate load

- **Isolated multi-PHP-FPM pools** per tenant or app type  
  → Predictable performance + fine-grained resource control

- **Brotli compression** (default level 6) + Gzip fallback  
  → 20–30 % smaller payloads than Gzip alone, especially beneficial for mobile

- **HTTP/2 + HTTP/3 (QUIC)** enabled out-of-the-box  
  → Multiplexing, header compression, significantly lower latency

- **Auto-tuned MariaDB / PostgreSQL** based on available RAM  
  → Dynamic buffer pools, query cache, slow-query logging + auto-EXPLAIN

- **Lazy service loading & on-demand activation**  
  → Postfix, Dovecot, PowerDNS, etc. only start when a tenant actually uses them

- **cgroups v2 + systemd resource limits** per tenant  
  → Strict CPU / RAM / I/O caps → eliminates noisy-neighbor problems

**Expected v1.0 results**  
Sub-second response times and high tenant density — even on 2–4 GB RAM VPS — while preserving strong isolation and security.

**We reject bloat**  
- No heavy JavaScript frameworks in the control backend  
- No unnecessary daemons running 24/7  
- No legacy Perl/PHP cruft in the core  

**Performance is not a feature — it's a non-negotiable invariant.**


---  

# 📦 Installation

⚠️ WCP 360 is currently in active development.

Planned installation:

```bash
git clone https://github.com/Webcontrolpanel360/wcp360.git
cd wcp360/installation
chmod +x install-wcp360.sh
sudo ./install-wcp360.sh
```

---

# 🌍 Join the Project

WCP 360 is building the future of Linux-native control panels.

If infrastructure deserves better tools:

**Join us.**
