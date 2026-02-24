# Security Policy

## Overview

WCP360 is a server control panel designed to manage multi-tenant environments, system resources, and user isolation.  
Security is a core priority of the project.

This document describes:

- How to report security vulnerabilities
- Supported versions
- Security design principles
- Disclosure process

---

## Supported Versions

Only the latest stable release is officially supported for security updates.

| Version | Supported |
|----------|------------|
| Latest stable | ✅ |
| Development branch | ⚠️ Best effort |
| Older releases | ❌ |

We strongly recommend always running the latest version.

---

## Reporting a Vulnerability

If you discover a security vulnerability, **do NOT open a public GitHub issue**.

Instead:

- Email: security@wcp360.com (replace with your real address)
- Or open a private security advisory via GitHub Security tab

Please include:

- Description of the issue
- Steps to reproduce
- Potential impact
- Suggested mitigation (if known)

We aim to respond within **48–72 hours**.

---

## Disclosure Policy

1. We acknowledge receipt of the report.
2. We investigate and validate the vulnerability.
3. A fix is developed and tested.
4. A security patch is released.
5. Public disclosure may follow after the fix is available.

We support responsible disclosure and will credit researchers (unless anonymity is requested).

---

## Security Design Principles

WCP360 is designed around the following principles:

### 1. Principle of Least Privilege

- Strict separation between:
  - Root / Admin (`wcpanel/`)
  - End-user accounts (`wpanel/`)
- No cross-account visibility.
- Scoped resource access.

### 2. Multi-Tenant Isolation

- Per-account resource scoping.
- Filesystem isolation.
- Strict API access boundaries.
- No shared state between tenants.

### 3. API-First Security

- Centralized authentication.
- Unified session management.
- Token-based or session-based access control.
- Future RBAC enforcement.

### 4. Secure Defaults

- Minimal exposed services.
- Explicit configuration required for advanced features.
- Hardened service configuration recommended.

---

## Backend Security (Go)

The backend is written in Go and follows:

- Static analysis (`go vet`)
- Linting (`golangci-lint`)
- Vulnerability scanning (`govulncheck`)
- Dependency validation via `go mod`

Recommended checks:
