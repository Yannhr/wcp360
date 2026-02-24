# 🚀 WCP 360  
### The Next-Generation Linux-Native Web Control Platform

[![License: AGPLv3](https://img.shields.io/badge/license-AGPLv3-blue.svg)](LICENSE)
[![Status](https://img.shields.io/badge/status-active%20development-orange)]()
[![Platform](https://img.shields.io/badge/platform-Debian%20%7C%20Ubuntu-green)]()
[![Architecture](https://img.shields.io/badge/architecture-Linux--native-black)]()
[![Modular](https://img.shields.io/badge/modular-yes-success)]()
[![Cloud Ready](https://img.shields.io/badge/cloud-ready-blueviolet)]()
[![GitHub stars](https://img.shields.io/github/stars/Webcontrolpanel360/wcp360?style=social)](https://github.com/Webcontrolpanel360/wcp360/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/Webcontrolpanel360/wcp360?style=social)](https://github.com/Webcontrolpanel360/wcp360/network/members)
[![GitHub issues](https://img.shields.io/github/issues/Webcontrolpanel360/wcp360)](https://github.com/Webcontrolpanel360/wcp360/issues)

---

## 🌍 What is WCP 360?

**WCP 360 (Web Control Panel 360)** is a next-generation, Linux-native control platform designed for hosting and server infrastructure.

It is:

- A modern web hosting control panel  
- A complete server management solution  
- A modular software platform for administering web infrastructure  

Full detailed roadmap → [ROADMAP.md](ROADMAP.md)  
Architecture & invariants → [ARCHITECTURE.md](ARCHITECTURE.md)  
Key features list → [FEATURES.md](FEATURES.md) (if exists)  
Installation guide → [INSTALLATION.md](INSTALLATION.md) or docs/ folder  
Security hardening tips → [HARDENING.md](HARDENING.md)

WCP 360 is built for modern environments and combines:

- Hosting management  
- Server administration  
- Infrastructure control  
- Multi-tenant isolation  
- Security-first architecture  

Designed for:

- 🖥 VPS servers  
- 🏢 Dedicated servers  
- ☁️ Cloud infrastructure

From small hosting providers to enterprise-grade infrastructure operators,  
WCP 360 scales seamlessly with your growth.

Built with:

- ⚡ Performance-first architecture  
- 🔐 Security by default  
- 🧱 A solid, secure, and reliable core  
- 🧩 Advanced features delivered through installable modules and plugins  
- ☁️ Cloud-ready scalability  
- 🐧 A pure Linux-native foundation 

## 🧩 Tech Stack Overview

### ⚙ Core Layer
[![Go](https://img.shields.io/badge/Core-Go-00ADD8?logo=go&logoColor=white)](https://go.dev/)
[![Rust](https://img.shields.io/badge/Security-Rust-black?logo=rust&logoColor=white)](https://www.rust-lang.org/)

### 🌐 Interface Layer
[![React](https://img.shields.io/badge/UI-React-61DAFB?logo=react&logoColor=black)](https://react.dev/)
[![Node.js](https://img.shields.io/badge/Runtime-Node.js-339933?logo=node.js&logoColor=white)](https://nodejs.org/)

### 🗄 Data Layer
[![MariaDB](https://img.shields.io/badge/Database-MariaDB-003545?logo=mariadb&logoColor=white)](https://mariadb.org/)
[![Redis](https://img.shields.io/badge/Cache-Redis-DC382D?logo=redis&logoColor=white)](https://redis.io/)

### 🌍 Infrastructure Layer
[![Nginx](https://img.shields.io/badge/Web%20Server-Nginx-009639?logo=nginx&logoColor=white)](https://nginx.org/)
[![PHP-FPM](https://img.shields.io/badge/PHP-FPM-777BB4?logo=php&logoColor=white)](https://www.php.net/)
[![Containers](https://img.shields.io/badge/Containers-Podman-892CA0?logo=podman&logoColor=white)](https://podman.io/)
[![Rootless](https://img.shields.io/badge/Mode-Rootless-success)]()
[![Quadlet](https://img.shields.io/badge/Orchestration-Quadlet-blue)]()
[![Systemd](https://img.shields.io/badge/Integration-systemd-444444)]()

### 🔐 Security Layer
[![Coraza](https://img.shields.io/badge/WAF-Coraza-red)](https://coraza.io/)
[![OWASP CRS](https://img.shields.io/badge/OWASP-CRS-critical)](https://owasp.org/www-project-modsecurity-core-rule-set/)

### 📦 Packaging
[![OCI-like](https://img.shields.io/badge/Modules-OCI--like-blueviolet)]()
[![Signed Manifests](https://img.shields.io/badge/Integrity-Signed%20Manifests-success)]()


---

# 🎯 Mission

To build a:

- Faster  
- More secure  
- Lightweight  
- Fully modular  
- Linux-native  
- Cloud-scalable  

infrastructure control platform engineered for modern systems.

WCP 360 is not a legacy hosting panel.  
It is an infrastructure control layer for serious server operators.

---

# 🧱 Target Infrastructure

## 🖥 VPS Servers

- Low footprint  
- Smart CPU/RAM allocation  
- Minimal overhead  
- High-density hosting  

## 🏢 Dedicated Servers

- Hardware-level optimization  
- Advanced MariaDB tuning  
- High I/O workloads  
- Enterprise-grade security  

## ☁️ Cloud & Scalable Instances

- API-first architecture  
- Cluster-ready roadmap  
- Multi-node orchestration (planned)  
- Infrastructure automation compatibility  

---

# 🐧 Supported OS

- Ubuntu LTS  
- Debian Stable  

Linux-native.  
No abstraction layers.  
No compatibility bloat.

---

# 🏗 Architecture Overview

## 🧠 Minimal Core

The core is:

- Immutable  
- Hardened  
- Event-driven  
- Fully extensible  

### Core Responsibilities

- User & domain lifecycle management  
- Resource isolation (cgroups v2 + systemd slices)  
- Dynamic Nginx config generation  
- SSL automation (ACME v2)  
- WAF integration (Coraza + OWASP CRS)  
- REST API Gateway  
- Plugin management  
- Security enforcement  

Everything is modular.  
Nothing is hardcoded.

---

# 🧩 Modular Ecosystem

Modules are installable packages.  
Install only what you need.

| Module | Purpose | Key Features |
|--------|---------|-------------|
| 🌐 **Web Server** | Website hosting stack | Nginx-first, multi-PHP, HTTP/3, Brotli |
| 🗄 **Database** | DB management | MariaDB & PostgreSQL provisioning |
| 📧 **Email** | Mail server | Postfix, Dovecot, Rspamd, Webmail |
| 🌍 **DNS** | Zone management | Bind / PowerDNS |
| 💾 **Backup** | Backup & restore | Incremental, S3, remote restore |
| 📁 **File Manager** | Web-based file access | Editor, permission view |
| 📊 **Monitoring** | Observability | Prometheus integration |
| 🔄 **Git Deploy** | CI/CD | Git-based deployment hooks |
| 🔐 **Security Suite** | Advanced protection | WAF, abuse detection, audit logs |


Third-party modules supported.

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

WCP360 is engineered for **maximum efficiency** and **minimal overhead** on production hosting environments.

We deliberately choose a **lean, modern stack** optimized for real-world VPS/dedicated servers:

- **Nginx-only** web server stack (no Apache legacy)  
  → Lightweight, event-driven, excellent concurrency handling

- **FastCGI caching** with intelligent purge rules  
  → Reduces backend PHP/MySQL hits for dynamic content

- **Redis object caching** (full-page, transients, sessions)  
  → Blazing-fast response times even under load

- **Multi-PHP-FPM pools** per tenant or application type  
  → Isolated performance + better resource control

- **Brotli compression** (level 6 default) + Gzip fallback  
  → Smaller payloads, faster page loads (especially mobile)

- **HTTP/2 + HTTP/3 (QUIC)** support out-of-the-box  
  → Multiplexing, header compression, lower latency

- **Auto-tuned MariaDB / PostgreSQL** configuration  
  → Query cache, InnoDB buffer pool sizing based on available RAM, slow query logging

- **Lazy service loading** & on-demand module activation  
  → Only start services (Postfix, Dovecot, PowerDNS, etc.) when a tenant actually uses them

- **cgroups v2** + systemd resource limits per tenant  
  → Prevents noisy-neighbor issues, enforces fair CPU/memory/disk I/O

Result: **sub-second response times** even on modest hardware, while maintaining strong isolation and security.

We avoid bloat: no heavy JavaScript frameworks in the control panel backend, no unnecessary daemons running 24/7, no legacy cruft.

Performance is not an afterthought — it's a core invariant.

Designed to handle 500+ domains efficiently.

---

# 🧠 Resource Management

Native alternative to CloudLinux LVE:

- cgroups v2  
- systemd slices  
- CPUQuota  
- MemoryHigh / MemoryMax  
- IO weight  
- Anti fork-bomb task limits  

Dynamic quotas per hosting plan.  
Smart throttling under load.

---

# 🧪 Developer-First Design

- CLI management (`wcp360`)  
- Full REST API  
- WebSocket updates  
- Git-based deployment  
- CI/CD hooks  
- SDK for module development  
- Infrastructure export/import  
- Optional container integration  

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

# 🤝 Contributing

We welcome:

- Backend developers  
- Frontend developers  
- Security engineers  
- DevOps specialists  
- Documentation contributors  
- Plugin developers  

### How to contribute

1. Fork the repository  
2. Create a feature branch  
3. Submit a Pull Request  
4. Join discussions  

---

# 🔥 Why WCP 360?

Because hosting panels should be:

- Transparent  
- Modular  
- Secure  
- Efficient  
- Developer-friendly  
- Scalable  

Not bloated.  
Not locked.  
Not overpriced.

---

# 🌍 Join the Project

WCP 360 is building the future of Linux-native control panels.

If infrastructure deserves better tools:

**Join us.**
