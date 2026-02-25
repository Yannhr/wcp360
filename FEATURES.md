# 🚀 WCP360 Key Features

WCP360 is not just a hosting panel; it's a high-performance orchestration engine built in Go. It focuses on automation, security, and the intelligent use of system resources.

---

## 🧠 Smart Resource Management (The "Elastic" Core)
* **Elastic Resource Allocation:** Unlike static limits, WCP360 uses a predictive loop to borrow idle CPU/RAM and give it to sites experiencing traffic spikes (Bursting).
* **Native cgroups v2 Integration:** No kernel overhead. Hard and soft limits are enforced directly by the Linux kernel.
* **PSI-Based Monitoring:** Real-time detection of I/O, CPU, and Memory pressure to rebalance the server before performance drops.
* **Instant Resource Reclaiming:** Resources are returned to the pool immediately after a peak ends.

---

## ⚡ High-Performance Web Stack
* **Dynamic Nginx Engine:** Automated generation of high-performance Nginx configurations with HTTP/2 and HTTP/3 (QUIC) support.
* **Multi-PHP-FPM Manager:** Supports multiple PHP versions running in isolated pools per user.
* **Fast-Path Gateway:** A single Go-based HTTPS entry point that handles routing, SSL termination, and rate-limiting.
* **Zero-Downtime Reload:** Configurations are validated and reloaded without dropping active connections.

---

## 🛡️ Security & Isolation (Zero-Trust)
* **Three-Tier Isolation:** Strict separation between System (Root), Panel (Web), and Client (Workload) domains.
* **Isolated Namespaces:** Every customer website runs in its own mount and network namespace.
* **Kernel Hardening:** Built-in profiles for AppArmor, SELinux, and Seccomp to restrict dangerous system calls.
* **Automated SSL (ACME):** Native Let's Encrypt integration with automatic DNS/HTTP-01 challenges and renewal.
* **Immutable Audit Trail:** All administrative actions are cryptographically signed and stored for compliance.

---

## 🗄️ Database & Email Ecosystem
* **Multi-Engine DB Support:** Native management for MariaDB and PostgreSQL.
* **Automated DB Backups:** Scheduled snapshots with local or remote (S3/FTP) storage.
* **Modern Email Stack:** Integrated Postfix/Dovecot management with SPF, DKIM, and DMARC automation.
* **Webmail Sandbox:** Run webmail interfaces (Roundcube/SnappyMail) in isolated environments.

---

## 📦 Intelligent Backup & Recovery
* **Incremental Backups:** Save space by backing up only changed blocks of data.
* **S3-Compatible Storage:** Native support for AWS S3, DigitalOcean Spaces, MinIO, and Backblaze.
* **Atomic Restore:** One-click restoration of website files, databases, and configuration settings.
* **Integrity Verification:** Automated checksums to ensure your backups are never corrupted.

---

## 🛰️ Future-Ready Infrastructure
* **Cluster Management:** Turn multiple servers into a unified hosting cluster (Master/Worker architecture).
* **Modular Plugin System:** Extend WCP360 using dynamically loaded Go modules or WASM.
* **Full-Go CLI:** A powerful Cobra-based command line for total automation via SSH or scripts.
* **Marketplace Ready:** Designed to support a future ecosystem of one-click apps and extensions.

---

## 🎨 User Experience (Full-Go UI)
* **Server-Side Rendered (SSR):** Fast, secure, and lightweight interface using Go Templates.
* **Zero JavaScript Dependency:** No heavy frameworks (React/Vue) needed; pure performance.
* **Responsive Dashboard:** Optimized for both mobile and desktop management.
* **Multi-Role RBAC:** Dedicated interfaces for Admins, Resellers, and End-Users.
