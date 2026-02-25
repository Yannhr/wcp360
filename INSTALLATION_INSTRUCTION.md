# 🚀 WCP360 Installation & Bootstrap Architecture

This document describes the automated deployment and initialization lifecycle for WCP360. Our goal is a **zero-configuration** experience that transforms a fresh Linux server into a production-ready environment via a single command.

---

## 🎯 1. Design Goals
The installation and first-boot system is engineered to:
* **One-Click Setup:** Require only one installation command.
* **Zero Config:** Avoid manual database or YAML file editing.
* **Secure Bootstrap:** Allow first login using existing server **root** credentials via PAM.
* **Auto-Provisioning:** Create default hosting packages and admin accounts automatically.
* **Hardened Transition:** Permanently disable root web access after initialization.
* **Idempotency:** Safe to re-run or interrupt without corrupting the system state.

---

## 🛠️ 2. Installation Stages

### Stage 1 — Preflight Checks
The installer validates the environment to ensure a successful deployment:
* **Privileges:** Must run as `root`.
* **OS:** Ubuntu 22.04+, Debian 11+, or RHEL 9+.
* **Hardware:** Minimum 2GB RAM / 10GB Disk.
* **Network:** Ports 80, 443, and 5432 must be available.
* **Kernel:** Version 5.10+ (Required for cgroups v2 and PSI).

### Stage 2 — Dependency Injection
Automated installation of required system services:
* **Database:** PostgreSQL (Primary Relational Store).
* **Proxy/Web:** Nginx (Gateway Interface).
* **Binary:** WCP360 Go Binary and Systemd service definition.

### Stage 3 — System Preparation
* Creates the `wcp360` system user.
* Automatically generates a secure, random database password and platform secrets.
* Writes the initial `/etc/wcp360/config.yaml`.
* Enables and starts the `wcp360` systemd service.

---

## 🔐 3. First Boot & Root Authentication

WCP360 uses a specialized **First Boot Mode** for secure initialization.

### Authentication Flow
1. **User opens Web Panel:** System detects `initialized: false`.
2. **First Boot Login:** Only the username `root` is accepted.
3. **PAM Verification:** The system verifies the password against the **Linux System Root Password** using PAM (Pluggable Authentication Modules).
4. **Transition:** Upon success, the bootstrap process begins.



---

## 🏗️ 4. Bootstrap Process
After successful root authentication, the system automatically triggers the bootstrap engine:

1. **Schema Migration:** Initializes the PostgreSQL database structure and tables.
2. **Admin Creation:** Prompts the user to create the first permanent **Admin Account**.
3. **Default Package:** Creates a standard hosting plan with predefined resource limits.
4. **Core Modules:** Enables required engines (Web, DB, DNS, SSL).
5. **Finalization:** Sets `initialized: true` in the system state and **permanently disables root login** via the web.

---

## 🛡️ 5. Security & Idempotency Safeguards

| Feature | Logic |
| :--- | :--- |
| **Root Lockdown** | Root web login is physically removed from the router post-init. |
| **Audit Trail** | All bootstrap actions are cryptographically logged in the audit table. |
| **Idempotency** | Checks for existing records before creation to avoid duplicate plans/users. |
| **Atomic Commits** | All provisioning steps are wrapped in SQL transactions to prevent partial setup. |

---

## 💾 6. System State Management

The system persists its initialization state to prevent repeated bootstrap execution and to lock down the PAM root login route permanently.

### State Structure
WCP360 tracks the lifecycle in the internal state (stored in the primary database):

* **`initialized` (boolean):** `false` during install, set to `true` after bootstrap success.
* **`installed_at` (timestamp):** The exact date/time the installer finished.
* **`bootstrap_at` (timestamp):** The exact date/time the root bootstrap was completed.



### Logic Enforcement
* **If `initialized == false`**: 
    - The Web UI redirects all traffic to the `/bootstrap` route.
    - Only the `root` user can authenticate via PAM.
* **If `initialized == true`**:
    - The `/bootstrap` route returns a **404** or **403 Forbidden**.
    - PAM authentication for `root` is physically disabled at the router level.
    - Only standard RBAC users (Admins/Tenants) can access the login gateway.

---

## 🚀 7. Final System State
After the process completes, the system is **Production Ready**:
* Standard Admin account exists.
* Default hosting package is active.
* Core modules (DNS, Web, DB) are enabled.
* Root web login is disabled.
* **WCP360 is ready for tenant provisioning.**

---

## 📂 8. Recommended Go Project Structure

```text
cmd/
  ├── wcpd/              # Main Daemon entry point
  ├── wcp-cli/           # Command Line Interface (Cobra based)

internal/
  ├── installer/         # Installation & OS logic
  │    ├── preflight.go     # System requirement checks
  │    └── dependencies.go  # OS package manager integration
  ├── auth/              # Security & First Login
  │    ├── auth.go          # Global Auth Interface
  │    ├── pam.go           # Linux PAM (CGO) for root login
  │    └── firstboot.go     # First-boot state logic
  ├── bootstrap/         # Initialization Logic
  │    ├── bootstrap.go     # Main orchestration
  │    ├── admin.go         # First Admin creation
  │    ├── packages.go      # Default Package setup
  │    └── modules.go       # Core Module activation
  ├── system/            # System & Config
  │    ├── state.go         # System state persistence
  │    └── config.go        # Configuration management
```

## Download and run the installer

```
curl -sSL https://raw.githubusercontent.com/Webcontrolpanel360/wcp360/main/install.sh | sudo bash

```



## 💻 Execution Command (Bash)

To trigger this entire flow on a fresh server, use:

```
#!/bin/bash

# ==============================================================================
# WCP360 UNIFIED INSTALLER
# Supported OS: Ubuntu 22.04+, Debian 11+
# ==============================================================================

set -e

# --- Configuration & Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🚀 WCP360 Installation starting...${NC}"

# --- 1. Root & OS Check ---
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}❌ Please run as root (sudo).${NC}" 
   exit 1
fi

# Detect Architecture
ARCH=$(uname -m)
case $ARCH in
    x86_64)  BINARY_ARCH="amd64" ;;
    aarch64) BINARY_ARCH="arm64" ;;
    *) echo -e "${RED}❌ Architecture $ARCH not supported.${NC}"; exit 1 ;;
esac

# --- 2. Dependency Installation ---
echo -e "${BLUE}📦 Installing PostgreSQL and system dependencies...${NC}"
apt update && apt install -y postgresql postgresql-contrib curl wget nftables

# --- 3. Database Auto-Configuration ---
echo -e "${BLUE}🗄️ Setting up PostgreSQL...${NC}"
DB_PASS=$(openssl rand -base64 16)

sudo -u postgres psql -c "CREATE USER wcp_admin WITH PASSWORD '$DB_PASS';" || true
sudo -u postgres psql -c "CREATE DATABASE wcp360_prod OWNER wcp_admin;" || true
sudo -u postgres psql -d wcp360_prod -c 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'

# --- 4. FHS Directory Setup ---
echo -e "${BLUE}📂 Creating system directories...${NC}"
mkdir -p /opt/wcp360/bin /etc/wcp360/ssl /var/lib/wcp360 /var/log/wcp360 /srv/www
useradd -r -s /usr/sbin/nologin wcp360 || true
chown -R wcp360:wcp360 /var/lib/wcp360 /var/log/wcp360

# --- 5. Binary Deployment ---
# Note: Une fois ton binaire publié, décommente la ligne wget ci-dessous
echo -e "${BLUE}📥 Fetching WCP360 binary ($BINARY_ARCH)...${NC}"
# wget -q https://github.com/Webcontrolpanel360/wcp360/releases/latest/download/wcp360_linux_$BINARY_ARCH -O /opt/wcp360/bin/wcp360
touch /opt/wcp360/bin/wcp360 # Placeholder
chmod +x /opt/wcp360/bin/wcp360
ln -sf /opt/wcp360/bin/wcp360 /usr/local/bin/wcp

# --- 6. Systemd Service Integration ---
echo -e "${BLUE}⚙️ Installing systemd service...${NC}"
cat <<EOF > /etc/systemd/system/wcp360.service
[Unit]
Description=WCP360 Hosting Panel
After=network.target postgresql.service

[Service]
Type=simple
User=root
ExecStart=/usr/local/bin/wcp start
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable wcp360

# --- 7. Summary ---
echo -e "${GREEN}✅ WCP360 Installation Successful!${NC}"
echo -e "------------------------------------------------"
echo -e "DB User: ${BLUE}wcp_admin${NC}"
echo -e "DB Pass: ${BLUE}$DB_PASS${NC}"
echo -e "------------------------------------------------"
echo -e "1. Login to: ${GREEN}https://$(hostname -I | awk '{print $1}')${NC}"
echo -e "2. Use username: ${BLUE}root${NC}"
echo -e "3. Use your SSH root password to begin bootstrap."
```
