📦 WCP360 Installation Guide

Welcome to the official WCP360 installation system.

This directory contains everything required to install WCP360 on a clean Linux server in a structured, modular, and production-ready way.

WCP360 is designed to be:

Linux-native

Modular

Secure by default

Reverse-proxy enforced

Upgrade-ready

Cluster-ready (future v2)

🖥 Supported Operating Systems

WCP360 currently supports:

Ubuntu 22.04 LTS

Ubuntu 24.04 LTS

Debian 11

Debian 12

Installation must be executed on a fresh server for best results.

⚙️ Installation Methods
🔹 Method 1 — Clone the Repository (Recommended for Development)

Run the following commands on your server:

git clone https://github.com/Yannhr/wcp360.git
cd wcp360/installation
chmod +x install-wcp360.sh
sudo ./install-wcp360.sh
🔹 Method 2 — One-Liner Installer (Production Use)

(Example – adjust when public wrapper is ready)

curl -fsSL https://your-domain.com/install.sh | sudo bash

This method:

Detects your OS

Downloads the correct installer

Executes installation automatically

🚀 What the Installer Does

The installer performs the following phases:

System validation (OS, RAM, disk, architecture)

Network configuration (hostname, FQDN, public IP)

Base package installation

Web server installation (Nginx and/or Apache)

PHP installation (multi-version support)

Database installation (MariaDB / PostgreSQL)

Mail stack (optional profile)

Security hardening (UFW, Fail2Ban, SSH hardening)

SSL configuration (Let’s Encrypt or fallback)

WCP360 Core daemon deployment

API Gateway installation

Admin Panel deployment

Service validation

Final summary display

📂 Installation Directory Structure Overview
installation/
├── public/
├── base/
├── steps/
├── libraries/
├── config/
├── templates/
├── pkg-lists/
├── systemd/
├── upgrade/
├── addons/
├── uninstall/
└── docs/

Each folder has a specific responsibility and is documented inside its own README.

🔐 Security Model

During installation, WCP360:

Creates a dedicated system user (wcp)

Restricts API access to localhost

Enforces reverse proxy via Nginx

Activates firewall rules

Enables Fail2Ban

Generates strong random passwords

Applies systemd hardening

No plaintext credentials are stored.

📋 Installation Requirements

Minimum recommended server specs:

2 GB RAM (4 GB recommended)

20 GB disk space

Clean OS install

Root access

🛑 Important Notes

Do NOT install on a server that already has another hosting panel.

Do NOT mix with cPanel, Plesk, Hestia, etc.

Always test on a staging VPS first.

Ensure ports 80 and 443 are open.

🔄 Upgrading

Future upgrades will be handled via:

installation/upgrade/

Version tracking is managed through:

installation/upgrade/current-version.txt
🧹 Uninstalling

To safely remove WCP360:

cd installation/uninstall
sudo ./uninstall.sh
🛠 Troubleshooting

If installation fails:

Check logs:

/var/log/wcp360-install.log

Review:

installation/docs/TROUBLESHOOTING.md
🏁 After Installation

Once completed successfully, the installer will display:

Panel URL

Admin username

Generated password

API endpoint

Service status

Access your panel via:

WCP360 v1.x