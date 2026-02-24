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

**WCP 360 (Web Control Panel 360)** is a next-generation, **Linux-native** infrastructure control platform. It moves beyond the limitations of legacy hosting panels to provide a high-performance orchestration layer for modern server environments.

WCP 360 isn't just a UI; it's a comprehensive ecosystem designed to manage the full lifecycle of web infrastructure with precision and speed.

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

### 💎 Core Pillars

WCP 360 scales seamlessly from independent hosting providers to enterprise-grade infrastructure operators, built on four foundational pillars:

* **⚡ Performance-First:** Low-latency execution with an event-driven, Nginx-native core.
* **🔐 Security by Design:** Zero-Trust architecture with centralized enforcement and tenant isolation (cgroups v2).
* **🧩 Modular Agility:** A lean core with powerful features delivered through hot-swappable modules and plugins.
* **🐧 Linux-Native:** No bloat, no heavy abstractions—just direct, efficient interaction with the OS.



### 🚀 Built For Modern Workloads

WCP 360 is engineered to handle:
* **Hosting Management:** Advanced domain, SSL, and multi-PHP lifecycle automation.
* **Server Administration:** Deep system control without leaving the platform.
* **Infrastructure Control:** Granular resource governance and process isolation.
* **Cloud Scalability:** Designed to evolve from single-node setups to distributed clusters.

---

**Built by serious operators, for serious operators.**

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

Our mission is to engineer a high-performance infrastructure control layer designed for the modern web. We are moving away from bloated legacy software to provide a platform that is:

* **⚡ Faster** – Optimized binaries and event-driven architecture.
* **🛡️ More Secure** – Zero-trust security model and hardened kernel integration.
* **🪶 Lightweight** – Minimal resource footprint to maximize your hardware's potential.
* **🧩 Fully Modular** – Install only what you need; extend everything else.
* **🐧 Linux-Native** – No heavy abstraction; direct interaction with systemd and cgroups v2.
* **☁️ Cloud-Scalable** – Built to grow from a single node to a distributed cluster.

> [!TIP]
> **WCP 360 is not just another legacy hosting panel.** It is a professional-grade **infrastructure control layer** built for serious server operators who demand precision and reliability.

---

# 🧱 Target Infrastructure

WCP 360 is optimized for diverse environments, ensuring peak performance regardless of the underlying hardware.

### 🖥️ VPS Servers
* **Ultra-Low Footprint:** Designed to run efficiently even on entry-level instances.
* **Intelligent Resource Allocation:** Smart CPU/RAM slicing via cgroups v2.
* **High-Density Hosting:** Maximize the number of tenants per node without overhead.

### 🏢 Dedicated Servers
* **Hardware-Level Tuning:** Direct optimization for bare-metal performance.
* **Enterprise Storage:** Advanced MariaDB/PostgreSQL tuning for high I/O workloads.
* **Hardened Security:** Full utilization of hardware-assisted security features.

### ☁️ Cloud & Scalable Instances (Upcoming Versions)
* **API-First Design:** Full RESTful API for seamless integration with external tools (In progress).
* **Cluster-ready Architecture:** Roadmap includes multi-node management and centralized state synchronization.
* **Multi-node Orchestration:** Future support for scaling across multiple geographic regions.
* **Infrastructure as Code (IaC):** Designed for Terraform and Ansible compatibility in upcoming releases.

> [!NOTE]
> The Cloud & Scalability features are the core focus of our **v3.0 roadmap**. We are currently perfecting the standalone core before moving to distributed orchestration.

---

# 🐧 Supported OS

WCP 360 is engineered to run as close to the Linux kernel as possible. We focus on distributions that guarantee long-term stability, enterprise-grade security, and native performance.

### 🔹 Tier 1: Debian-based (Production Ready)
* **Ubuntu LTS** (20.04, 22.04, 24.04+)
* **Debian Stable** (11 Bullseye, 12 Bookworm+)

### 🔹 Tier 2: Enterprise Linux (RHEL Family - Incoming)
* **AlmaLinux 9+** (The new industry standard for professional hosting)
* **Rocky Linux 9+** (Community-driven enterprise stability)
* **CloudLinux** (Advanced tenant isolation for shared hosting environments)

### 🔹 Tier 3: Specialized (Roadmap)
* **Alpine Linux** (For ultra-minimalist, high-performance edge deployments)

---

**Linux-native.** **No abstraction layers.** **No compatibility bloat.**

> [!IMPORTANT]
> **Architecture Note:** We exclusively target systems utilizing **systemd** and **cgroups v2**. This ensures native resource isolation and hardware-level performance without the overhead of third-party virtualization layers.

---

### Why these Operating Systems?
By expanding support to the **RHEL family (Alma/Rocky)**, WCP 360 positions itself as a direct, high-performance alternative to legacy proprietary panels, enabling seamless migrations for enterprise-scale infrastructures.

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
