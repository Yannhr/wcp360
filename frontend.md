# Frontend

WCP360 follows a modern **API-first** architecture with **two separate frontend applications** that share the same unified backend.

The goal is to clearly separate **server-wide administration** from **end-user account management**, while keeping a consistent technology stack and a single source of truth for business logic via the backend.

---

## Overview

WCP360 ships two web apps:

- **`wcpanel/`** → Admin / reseller interface (**WHM-like**)
- **`wpanel/`** → Client / end-user interface (**cPanel-like**)

Both consume the same backend:

- **REST API** (typically under `api/`)
- **Core services** (typically under `core/`)
- **WebSocket** for real-time events (logs, status updates, metrics, etc.)

---

## `wcpanel/` — Admin / Reseller UI (WHM-like)

The `wcpanel/` application is intended for:

- Root users
- Administrators
- Resellers (with role-based limitations planned)

### Responsibilities

This UI focuses on **server-wide management**, including:

- Global overview of all accounts
- Resource quotas, isolation and monitoring
- Global server configuration
- Module / plugin installation and updates
- Security policies and hardening settings
- Audit logs and admin activity tracking
- System status and health monitoring
- Multi-tenant administration tools

### Access control

This interface is designed for privileged roles.  
**RBAC (Role-Based Access Control)** is planned to support:

- Root / Admin
- Reseller
- Limited admin roles

---

## `wpanel/` — Client UI (cPanel-like)

The `wpanel/` application is intended for:

- End users / account owners

### Responsibilities

This UI provides a **self-service dashboard**, scoped strictly to the logged-in user’s resources:

- File manager
- Domain and DNS management
- Email accounts
- Database management
- Backups and restore
- Resource usage graphs (CPU/RAM/Disk/Bandwidth)
- SSL certificate management
- Account-level settings

### Tenant isolation

Users have **no visibility** into other accounts and cannot manage server-wide configuration.  
All operations are scoped to the authenticated tenant.

---

## Tech Stack

Both frontends share the same modern stack:

- **TypeScript**
- **React**
- **Next.js (or a similar modern React framework)**
- **pnpm workspace / monorepo tooling**

They share backend integration patterns:

- Unified authentication and session handling
- Shared API contracts
- Consistent error and permission handling
- Real-time updates via WebSocket

---

## Repository Structure (expected)

A typical structure looks like:
