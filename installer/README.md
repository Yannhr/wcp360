# WCP360 Enterprise Bootstrap Installer

## Overview

The `installer/` directory contains the **official enterprise-grade bootstrap system** for WCP360.

It is designed to:

- Prepare a fresh Ubuntu/Debian server
- Install required system dependencies
- Deploy the WCP360 core daemon
- Configure API gateway and panel
- Enforce reverse proxy architecture
- Secure the server
- Provide transaction-safe installation
- Support idempotent re-execution
- Enable automatic HTTPS
- Maintain installation state tracking

This installer follows modern DevOps best practices and is built for production-grade environments.

---

# Architectural Philosophy

The installer is built around a **fully orchestrated modular bootstrap system**:

```bash
main() {
  preflight_checks
  install_system_layer
  install_core_daemon
  install_api_gateway
  install_panel
  configure_reverse_proxy
  initialize_database
  enable_ssl
  secure_server
  validate_services
}
```

Each phase is atomic, idempotent, and recoverable.

---

# Directory Structure

```
installer/
├── bootstrap/
│   ├── install-wcp360.sh
│   └── state-machine.sh
│
├── profiles/
│   ├── minimal.profile
│   └── full.profile
│
├── utils/
│   ├── logger.sh
│   ├── system.sh
│   ├── idempotent.sh
│   ├── password.sh
│   ├── validation.sh
│   └── json.sh
│
├── security/
│   ├── gpg-verify.sh
│   └── hardening.sh
│
├── rollback/
│   └── rollback.sh
│
├── steps/
│   ├── 01-system.sh
│   ├── 02-core.sh
│   ├── 03-api.sh
│   ├── 04-panel.sh
│   ├── 05-nginx.sh
│   ├── 06-database.sh
│   ├── 07-ssl.sh
│   ├── 08-security.sh
│   └── 09-validate.sh
│
├── nginx/
│   └── wcp360.conf
│
└── systemd/
    └── wcp360.service
```

---

# Directory Responsibilities

## bootstrap/

Main orchestration layer.

- Executes installation steps sequentially
- Maintains installation state
- Loads selected profile
- Handles auto mode and domain configuration
- Triggers rollback on failure

---

## profiles/

Defines installation profiles:

- `minimal.profile` → Core + reverse proxy + security
- `full.profile` → Full stack (DB, SSL, Panel, API, Security)

Profiles allow flexible deployment scenarios.

---

## utils/

Shared utilities used by all steps.

### logger.sh
- Structured JSON logging
- Secure log file handling

### system.sh
- OS detection
- Root validation
- Internet connectivity checks

### idempotent.sh
- Safe package installation
- Service validation
- Re-run safe helpers

### password.sh
- Strong password generator (OpenSSL)

### validation.sh
- Service validation helpers

### json.sh
- JSON manipulation helpers (if jq installed)

---

## security/

Security enforcement layer.

### gpg-verify.sh
- Verifies installer integrity via GPG signature

### hardening.sh
- Applies additional OS-level hardening policies

---

## rollback/

Provides automatic recovery if a critical failure occurs.

Rollback behavior:

- Stops services
- Removes partial installation artifacts
- Prevents broken runtime state

---

## steps/

Contains atomic installation phases executed sequentially.

| Step | Responsibility |
|------|---------------|
| 01-system.sh | Install base system packages |
| 02-core.sh | Deploy WCP360 daemon |
| 03-api.sh | Configure internal API |
| 04-panel.sh | Deploy admin/client panel |
| 05-nginx.sh | Configure reverse proxy |
| 06-database.sh | Initialize secure database |
| 07-ssl.sh | Automatic HTTPS via Certbot |
| 08-security.sh | UFW + Fail2Ban |
| 09-validate.sh | Post-install validation |

Each step is:

- Idempotent
- Safe to re-run
- Transaction-aware

---

## nginx/

Reverse proxy configuration.

Responsibilities:

- Enforce single public entrypoint
- Route `/api` internally
- Serve panel
- Prepare HTTPS redirection

---

## systemd/

Contains hardened service unit file.

Security features:

- NoNewPrivileges
- ProtectSystem
- ProtectHome
- MemoryDenyWriteExecute
- Dedicated system user (`wcp`)

---

# Security Features

The installer enforces:

- Strong password generation
- No plaintext credentials
- Dedicated daemon user
- Reverse proxy mandatory
- Internal API binding only
- UFW deny-by-default
- Fail2Ban enabled
- systemd sandboxing
- Optional GPG signature verification
- Structured logging for audit trail

---

# Logging

Structured JSON log:

```
/var/log/wcp360-install.json
```

Each log entry:

```json
{
  "timestamp": "2026-02-22T21:00:00Z",
  "level": "INFO",
  "message": "Installing nginx"
}
```

---

# Installation State Tracking

State file:

```
/var/lib/wcp360/install-state.json
```

Used for:

- Crash recovery
- Debugging
- Resume support (future enhancement)

---

# Installation Modes

## Interactive

```
sudo bash install-wcp360.sh
```

## Full Auto Mode

```
sudo bash install-wcp360.sh --profile=full --auto --domain=example.com
```

## Minimal Mode

```
sudo bash install-wcp360.sh --profile=minimal --auto
```

---

# Automatic HTTPS

If a domain is provided:

```
--domain=example.com
```

The installer:

- Installs Certbot
- Requests certificate
- Configures HTTPS
- Enables automatic renewal

---

# Post-Installation Summary

At completion, the installer displays:

- Panel URL
- API endpoint
- Database credential location
- Log file path

---

# Idempotence Policy

The installer:

- Checks before installing packages
- Verifies services before restarting
- Uses conditional resource creation
- Prevents duplicate users and DB entries

Safe to re-run without breaking the system.

---

# Production Readiness

This installer is designed for:

- Linux-native deployment
- Modular architecture
- Commercial-grade extensibility
- Secure public exposure
- Future cluster evolution

---

# Future Roadmap

- Cluster auto-discovery
- mTLS internal API
- High availability mode
- Distributed state sync
- Binary bootstrap version
- Remote marketplace integration

---

# License

See project root `LICENSE`.

---

WCP360 — Linux-Native Web Control Platform