# 🏛️ WCP360 System Architecture (Full-Go Edition)

## 🎯 The Core Philosophy: "Single Binary Infrastructure"

WCP360 is a **zero-dependency** hosting operating system. By eliminating external frontend frameworks like React, we achieve a level of security and simplicity unattainable by legacy panels. 

The entire stack — from kernel orchestration to the user interface — is built in **Pure Go**.

---

## 🏗️ The Three-Tier Isolation Model

### 1. 🔴 SYSTEM LAYER (The Controller)
* **Binary:** `wcpd` (The Heart).
* **Role:** Manages eBPF, cgroups v2, and systemd slices.
* **Privilege:** Starts as `root` for low-level calls, then drops to `wcp360` user.

### 2. 🔵 PANEL LAYER (Server-Side UI)
* **Engine:** Go `html/template` + Standard Library.
* **Delivery:** UI assets are embedded into the Go binary using `go:embed`.
* **Security:** No client-side logic. All state management remains on the server.
* **Style:** Utility-first CSS (Tailwind) delivered via CDN or embedded CSS.

### 3. 🟢 CLIENT LAYER (The Workload)
* **Isolation:** Namespaced environments for customer processes.
* **Resource:** Managed via the **Predictive Reconciliation Loop** (Elastic CPU/RAM).

---

## ⚡ Unified Go Stack

| Component | Technology | Benefit |
| :--- | :--- | :--- |
| **Backend** | Go (Gin + Uber-Zap) | Speed & Structured Logging |
| **Frontend** | Go Templates (SSR) | Zero JS overhead, Secure by design |
| **CLI** | Go (Cobra) | Native Linux feel |
| **Monitoring** | Go (eBPF / PSI) | Real-time kernel insights |

---

## 📂 Filesystem Strategy (FHS Compliant)

| Directory | Purpose | Security |
| :--- | :--- | :--- |
| `/opt/wcp360/` | Single Static Binary (`wcp360`) | 0700 / Root |
| `/etc/wcp360/` | Configs, API Keys, SSL | 0700 / Root |
| `/var/lib/wcp360/` | Persistent state & DB | 0700 / wcp360 |
| `/var/log/wcp360/` | Audit & Security logs | Append-only |
| `/srv/www/` | Customer website roots | Isolated Jails |

---

## 🛡️ Absolute Security Rules

1. **Self-Contained:** No external web server required. WCP360 is its own high-performance web server.
2. **Context Separation:** The UI and the System Provider communicate via internal Go interfaces, never exposing raw system calls to the web layer.
3. **No Node.js:** Zero risk of supply chain attacks via NPM.
4. **Binary Integrity:** The panel cannot be tampered with on the filesystem (all logic is compiled).

---
```text
# 1. System User Setup
useradd -r -s /usr/sbin/nologin wcp360

# 2. Filesystem Initialization
mkdir -p /opt/wcp360/bin /etc/wcp360/ssl /var/lib/wcp360 /var/log/wcp360 /srv/www

# 3. Ownership & Permissions
chown -R root:root /opt/wcp360 /etc/wcp360
chown -R wcp360:wcp360 /var/lib/wcp360 /var/log/wcp360

chmod 700 /opt/wcp360 /etc/wcp360 /var/lib/wcp360
chmod 751 /srv/www

# 4. Binary Deployment (Mockup command)
mv wcp360 /opt/wcp360/bin/
ln -s /opt/wcp360/bin/wcp360 /usr/local/bin/wcp
```
