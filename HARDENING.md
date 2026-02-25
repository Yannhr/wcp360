# 🔐 WCP360 Hardening & Security Standards

WCP360 is built with a **Security-First** mindset. Our goal is to minimize the attack surface of the hosting environment through strict isolation and kernel-level enforcement.

---

## 🏗️ 1. Process & Privilege Isolation

### Privilege Dropping (The Bootstrap Rule)
The `wcp360-core` daemon requires `root` privileges ONLY for the following startup tasks:
* Binding to privileged ports (443).
* Configuring `cgroups v2` and `namespaces`.
* Setting up `nftables` rules.
* Mounting customer filesystems.

**Action:** Immediately after bootstrap, the daemon drops privileges to the unprivileged `wcp360` system user.

### Three-Tier Domain Separation
We strictly forbid any communication that bypasses the architectural layers:
* **System Layer:** Cannot execute user scripts.
* **Panel Layer:** Cannot read raw database files directly; must use the API.
* **Client Layer:** Jailed in a "No-Exit" environment (Namespaced).

---

## 🛡️ 2. Kernel-Level Protection

### cgroups v2 & Resource Jailing
Every user is assigned to a specific `systemd.slice`. This prevents:
* **Fork Bombs:** via `pids.max` limits.
* **Resource Exhaustion:** via hard memory and CPU limits.
* **Noisy Neighbors:** via I/O weight balancing.



### Namespacing & Chroot
Customer environments are isolated using:
* **Mount Namespaces:** Users only see their own `/srv/www/{user}` directory. Common system paths (`/etc`, `/usr`) are mounted as Read-Only.
* **Network Namespaces (Optional):** Restricts users from seeing local loopback traffic from other customers.

### Landlock & Seccomp
We use Linux **Landlock** (available in recent kernels) to restrict file access even if a process is compromised.
* **Seccomp Profiles:** Only allow the minimum necessary syscalls for PHP/Node.js/Static serving.

---

## 🌐 3. Network Hardening

### The Gateway Pattern
* **Zero-Exposed Ports:** Only Port 443 (HTTPS) is open to the WAN.
* **Internal Sockets:** All communication between the UI and the Core Daemon happens via **Unix Domain Sockets** (`/run/wcp360/wcp.sock`) with 0700 permissions.
* **NFTables Integration:** WCP360 manages a dynamic firewall that automatically drops brute-force attempts at the kernel level.

### SSL/TLS Standards
* **Minimum TLS 1.2:** (TLS 1.3 preferred).
* **HSTS:** Enabled by default on all panel routes.
* **Automatic ACME:** No manual certificate handling; automated renewal reduces the risk of expired/fake certs.

---

## 💾 4. Data & Configuration Security

### Filesystem Permissions (FHS Compliance)
| Path | Owner | Permissions | Why? |
| :--- | :--- | :--- | :--- |
| `/etc/wcp360/` | `root` | `0700` | Contains API keys and master secrets. |
| `/opt/wcp360/bin/` | `root` | `0755` | Prevent tampering with the Go binary. |
| `/var/lib/wcp360/` | `wcp360`| `0700` | Runtime data protected from other users. |

### Database Security
* **Unique Sockets:** Databases are accessed via local sockets where possible.
* **One User, One DB:** Strict enforcement of the principle of least privilege for SQL users.

---

## 📜 5. Immutable Auditing
Every administrative action (via CLI or Web) generates a **Signed Audit Log**:
* Stored in `/var/log/wcp360/audit.json`.
* Contains: `Timestamp`, `Actor_ID`, `Action`, `Resource_ID`, `IP_Address`.
* Logs are append-only to prevent attackers from covering their tracks.

---

## 🚀 6. Security Maintenance (Bash commands)
```
#!/bin/bash
echo "🔍 Running WCP360 Security Audit..."

# 1. Check for leaking ports
LEAKING=$(ss -tulpn | grep LISTEN | grep -v ':443' | grep -v '127.0.0.1')
if [ ! -z "$LEAKING" ]; then
    echo "⚠️ WARNING: Non-standard ports are exposed publicly!"
fi

# 2. Verify Config Permissions
if [ "$(stat -c %a /etc/wcp360)" -ne "700" ]; then
    echo "❌ CRITICAL: /etc/wcp360 permissions are too open!"
fi

# 3. Check for cgroups v2
grep -q "cgroup2" /proc/mounts && echo "✅ cgroups v2 active" || echo "❌ cgroups v2 MISSING"

# 4. Check for PSI (Pressure Stall Information)
[ -f /proc/pressure/cpu ] && echo "✅ PSI monitoring enabled" || echo "⚠️ PSI disabled (AI scaling limited)"
```
