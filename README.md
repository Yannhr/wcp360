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

**WCP 360 (Web Control Panel 360)** is a modern, lightweight, fully modular control platform engineered for:

- 🖥 VPS servers  
- 🏢 Dedicated servers  
- ☁️ Cloud infrastructure  

Designed as a progressive alternative to:

- cPanel  
- Plesk  
- CyberPanel  
- HestiaCP  

Built with:

- ⚡ Performance-first architecture  
- 🔐 Security-by-default design  
- 🧩 Modular core  
- ☁️ Cloud-ready scalability  
- 🐧 Pure Linux-native foundation  



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

## 🧠 Minimal Core (< 50MB installed)

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

Security is built-in:

- User isolation (cgroups v2)  
- CPU/RAM/IO quotas  
- WAF (auto-updated rules)  
- Abuse detection engine  
- Immutable audit logs  
- Mandatory 2FA  
- WebAuthn support  
- SELinux/AppArmor profiles  
- Automatic hardening on install  

Zero-trust architecture.  
No root execution from UI.

---

# ⚡ Performance Philosophy

Built for speed:

- Nginx-only stack  
- FastCGI caching  
- Redis object cache  
- Multi-PHP pools  
- Brotli compression  
- HTTP/3  
- Auto-tuned MariaDB  
- Lazy service loading  

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

# 🌱 Sustainability

Optional infrastructure metrics:

- Per-site resource tracking  
- Energy usage estimation  
- CO₂ metrics  

Built for efficient infrastructure usage.

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

# 📜 License

WCP 360 Core is released under:

**AGPLv3**

Ensuring:

- Core remains open-source  
- No closed forks  
- Commercial hosting allowed  
- Paid modules may coexist separately  

---

# 🛣 Roadmap (2026)

- Core engine MVP  
- Web server module  
- Database module  
- Email module  
- Backup module  
- API v1 stable  
- Plugin registry  
- Cluster mode (beta)  
- Public SDK  

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
