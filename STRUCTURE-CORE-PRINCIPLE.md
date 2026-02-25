
# 🏗️ WCP360 System Architecture & Filesystem Layout

## 🎯 The Core Philosophy

WCP360 is not a web app; it is a **lightweight hosting operating system**. To achieve enterprise-grade security and horizontal scalability, we enforce a strict separation of three distinct execution domains:

1.  **🔴 SYSTEM LAYER** → Root-level orchestration, eBPF monitoring, and kernel-level management.
2.  **🔵 PANEL LAYER** → Management interface and API gateway (Isolated, non-root).
3.  **🟢 CLIENT LAYER** → Untrusted customer workloads (Namespaced, cgrouped, and jailed).

> **Crucial Rule:** Never mix these worlds. Mixing them breaks security, prevents scaling, and compromises commercial distribution.

---
## Recommended Filesystem Layout for WCP360 (production server)
```text
/  
├── opt/wcp360/             # Core panel binaries & static assets (ROOT ONLY)  
├── etc/wcp360/             # Sensitive configuration files  
├── var/lib/wcp360/         # Persistent runtime data & state  
├── var/log/wcp360/         # Logs (immutable + auditable)  
├── srv/www/                # Customer websites (preferred modern location)  
├── home/                   # Linux user home directories (optional fallback)  
└── run/wcp360/             # Runtime files: sockets, pidfiles (tmpfs)
```

## 📂 Production Filesystem Layout (FHS Compliant)

WCP360 follows the **Linux Filesystem Hierarchy Standard (FHS)** for maximum compatibility with Ubuntu/Debian.


### 1. 🛡️ Core Panel binaries (`/opt/wcp360/`)
*Dedicated to third-party software packages.*
Core Panel (most sensitive part)/opt/wcp360/ — follows Linux FHS convention for third-party software

```text
/opt/wcp360/
├── bin/                        # Statically compiled Go binaries
│   ├── wcp360-core             # Main daemon (starts as root → drops privileges)
│   ├── wcp360-agent            # Per-node agent (for clustering)
│   ├── wcp360-gateway          # Single public HTTPS entry point
│   └── wcp360-cli              # Command-line tool (symlink → /usr/local/bin)
├── lib/                        # Shared libraries / wasm modules / helpers
├── ui/                         # Frontend static assets — NEVER expose directly
│   ├── adminpanel/                  # Admin interface files
│   ├── userpanel/                   # End-user control panel files
│   └── common/                 # Shared components, images, css, js
├── internal/                   # Go internal packages (not exposed)
├── plugins/                    # Dynamically loaded extensions
├── scripts/                    # Maintenance / upgrade / post-install scripts
└── version                     # Current installed version
```
    Permissions: chown -R root:root | chmod -R 700

## 2. 🔑 Sensitive Configuration (/etc/wcp360/)

The "Brain" of the installation.

```text
/etc/wcp360/
├── wcp360.yaml               # Main configuration
├── api.key                   # Master API key (generated at install)
├── cluster.token             # Cluster join token (multi-node)
├── db.yaml                   # Database connection(s)
├── ssl/                      # System / wildcard / ACME certificates
│   ├── fullchain.pem
│   └── privkey.pem
├── hardening/                # SELinux / AppArmor / nftables profiles
└── modules/                  # Per-module configuration (web, mail, db, etc.)
```

    Permissions: chown -R root:root | chmod 700 /etc/wcp360 | chmod 600 

## 3. 📊 State & Persistence (/var/lib/wcp360/) Runtime & persistent state

The "Memory" of the system.

```text
/var/lib/wcp360/
├── accounts/                 # User accounts metadata + cgroups quotas
├── nodes/                    # Cluster node status
├── state.db                  # Embedded DB (sqlite / badger / bolt)
├── cache/                    # Redis / FastCGI / asset cache
├── jobs/                     # Async job queue storage
├── backups/                  # Local backup staging (before S3 / remote)
└── ssl/                      # Per-domain Let's Encrypt / other certs
```
### Ownership: usually wcp360:wcp360 (dedicated system user)
### Permissions: chmod 700 /var/lib/wcp360



## 4. 📜 4. Logs (should be append-only / auditable)

```text
/var/log/wcp360/
├── core.log
├── gateway.log
├── audit.json                # Immutable audit trail
├── security.log
└── modules/
```
→ Use logrotate + forward to Loki / ELK / Graylog

## 🌐 5. Public Web Access (single entry point – critical)

## Network Ports & Exposure Rules

WCP360 is designed to **minimize public exposure** and enforce **strict security by default**.

Only the ports listed below should be **publicly accessible** (via reverse proxy or direct binding in limited cases).  
**All other ports must remain internal** (bound to localhost / 127.0.0.1 or private network only).

| Resource              | Description                                      | Recommended Public Port | Internal Binding (example) | Protocol / Notes / Security Recommendations |
|-----------------------|--------------------------------------------------|--------------------------|----------------------------|---------------------------------------------|
| **/admin**            | Administration & reseller panel                  | 443 (HTTPS)             | :2094                     | Reverse proxy + HTTPS only |
| **/user**             | Client / end-user control panel                  | 443 (HTTPS)             | :2092                     | Reverse proxy + HTTPS only |
| **/api/**             | REST + GraphQL API endpoints                     | 443 (HTTPS)             | :2098                     | Reverse proxy + HTTPS only, rate-limited |
| **/webmail**          | Webmail interface (Roundcube / SnappyMail…)      | 443 (HTTPS)             | :2096                     | Reverse proxy + HTTPS only |
| **/.well-known/**     | ACME HTTP-01 challenges (Let's Encrypt)         | 80 (HTTP)               | —                         | Temporary for cert issuance – redirect to HTTPS otherwise |
| **SMTP**              | Mail transfer (Postfix outbound)                 | Not exposed publicly    | :25                       | **Never expose port 25 publicly** – high spam / open relay risk |
| **Submission**        | Authenticated mail submission (clients)          | 587 (recommended)       | :587                      | STARTTLS + mandatory authentication |
| **SMTPS**             | Legacy secure SMTP                               | 465                     | :465                      | SSL/TLS wrapper – use only if legacy clients require it |
| **IMAP**              | Mail retrieval (Dovecot)                         | Not exposed publicly    | :143                      | **Never expose in clear** – prefer IMAPS |
| **IMAPS**             | Secure IMAP                                      | 993                     | :993                      | SSL/TLS mandatory – primary recommendation |
| **POP3**              | Legacy mail retrieval                            | Not exposed publicly    | :110                      | **Deprecated** – use IMAPS instead |
| **POP3S**             | Secure POP3                                      | 995                     | :995                      | SSL/TLS – only if legacy clients insist |

**Critical Security Rule**  
No other ports should be open publicly (not even temporarily).  
Force **HTTP → HTTPS redirection** at the edge (Nginx / Caddy / Traefik) and bind all internal services (SMTP, IMAP, API internals, etc.) to **127.0.0.1** or localhost only.

### Recommended Email Security Guidelines
- **Port 25 (SMTP)**: **Never expose it** to the Internet — use it only for internal relay between servers.
- **Port 587 (Submission)**: Primary choice for client mail sending — enforce STARTTLS + authentication.
- **Port 465 (SMTPS)**: Legacy SSL wrapper — acceptable only if required by old clients.
- **IMAPS (993)**: Always use this for IMAP access — never allow plain IMAP (143) over public networks.
- **POP3S (995)**: Only if POP3 is needed — IMAPS is strongly preferred in 2026.
- Use a **reverse proxy** for webmail only (`/webmail/` → proxy to :2096 internally).
- Firewall rules (nftables / firewalld): Block everything except 80 & 443 from the public Internet.

### Example Nginx Reverse Proxy Snippet (for HTTPS enforcement)
```
nginx
server {
    listen 80;
    listen [::]:80;
    server_name panel.example.com;

    # Force HTTPS redirect
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name panel.example.com;

    ssl_certificate /etc/letsencrypt/live/panel.example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/panel.example.com/privkey.pem;

    location /admin/ {
        proxy_pass http://127.0.0.1:2094/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location /user/ {
        proxy_pass http://127.0.0.1:2092/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location /api/ {
        proxy_pass http://127.0.0.1:2098/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location /webmail/ {
        proxy_pass http://127.0.0.1:2096/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location /.well-known/acme-challenge/ {
        root /var/www/acme;
    }
}
```
## 6. Customer Websites – Strong Isolation (Recommended Structure)

WCP360 enforces **strict per-tenant isolation** using Linux namespaces, cgroups v2, and filesystem separation.

Recommended layout (modern, clean, secure, and scalable):


```
/srv/www/
├── user123/                        # tenant username or UUID
│   ├── public_html/                # document root – only this is served by Nginx
│   │   ├── index.html
│   │   ├── wp-content/             # example for WordPress
│   │   └── ...
│   ├── logs/                       # tenant-specific access/error logs
│   │   ├── access.log
│   │   └── error.log
│   ├── tmp/                        # PHP session files, uploads temp, etc.
│   ├── backups/                    # optional: tenant self-backups
│   ├── private/                    # non-public files (configs, keys, scripts)
│   └── .system/                    # internal metadata (read-only for tenant)
│       ├── cgroup.slice            # cgroup v2 slice name or path
│       ├── quota.json              # current enforced quotas
│       └── runtime.pid             # optional: main process PID
├── user456/
│   ├── public_html/
│   ├── logs/
│   ├── tmp/
│   ├── private/
│   └── .system/
└── ...
```
### Why this structure?

| Directory       | Purpose                                                                 | Visibility / Permissions                     | Security / Isolation Benefits |
|-----------------|-------------------------------------------------------------------------|----------------------------------------------|-------------------------------|
| `public_html/`  | Nginx document root – only this path is served                          | 755 / www-data:www-data                      | Chroot / namespace can restrict access here only |
| `logs/`         | Tenant-specific Nginx/Apache/PHP-FPM logs                               | 750 / root:adm or tenant-log group           | Prevents log injection / log flooding from one tenant to another |
| `tmp/`          | Temporary files (sessions, uploads, cache)                             | 1777 / sticky bit (like /tmp)                | Per-tenant tmpfs possible via namespace |
| `backups/`      | Optional tenant-controlled backups                                      | 700 / tenant-user:tenant-group               | Tenant can manage own restores without full access |
| `private/`      | Configs, API keys, .env, custom scripts – never served                  | 700 / tenant-user:tenant-group               | Not exposed to web server at all |
| `.system/`      | Internal WCP360 metadata (read-only for tenant)                         | 555 / root:root                              | Contains cgroup slice info, quota enforcement data, runtime state |

### Key Security & Isolation Principles

- **Filesystem isolation** — each tenant has its own root directory under `/srv/www/`
- **Ownership** — all files/folders owned by a dedicated per-tenant user/group (e.g. `user123:user123`)
- **Nginx config** — `root /srv/www/user123/public_html;` + `open_file_cache` per vhost
- **cgroups v2** — each tenant runs under its own systemd slice: `/system.slice/wcp360-user123.slice`
- **No shared /tmp** — use per-tenant tmpfs mounts or private `/tmp` via namespaces
- **SELinux / AppArmor** — optional profiles per tenant directory (future module)
- **Backup exclusion** — `.system/` and `logs/` excluded from tenant-accessible backups

### Alternative layouts considered (and why avoided)

- `/home/user/public_html` → Avoided: mixes system users with web tenants
- `/var/www/vhosts/user/` → Classic but legacy (cPanel-style) → we prefer `/srv/www/`
- Flat `/srv/www/domain.com/` → No strong tenant isolation if multiple domains per tenant

This layout is **clean**, **scalable**, **backup-friendly**, and **strongly isolated** — perfect for a modern multi-tenant control panel like WCP360.

Add this section to your **ARCHITECTURE.md** or **HARDENING.md** as-is (or tweak paths if you prefer `/var/www/tenants/` or similar).

Want a matching **Nginx vhost template example** or **systemd slice creation snippet** to go with it? Let me know! 🚀

## Absolute Security Rules (Non-Negotiable Invariants)

These rules are **hard invariants** in WCP360 — they must never be violated, even for convenience or legacy compatibility.  
They form the foundation of the platform's zero-trust model and strong isolation guarantees.

1. **Never place panel files in /home, /var/www, or /usr/local**  
   - All WCP360 files live under `/opt/wcp360` (binaries & code), `/etc/wcp360` (config), `/var/lib/wcp360` (data/state), and `/var/log/wcp360` (logs).  
   - Rationale: These standard paths are reserved for system/user content or legacy web hosting. Mixing them increases risk of accidental exposure or permission escalation.

2. **Never commit secrets, keys, or sensitive configs to Git**  
   - Use `.gitignore` aggressively for `.env`, `*.key`, `*.pem`, `config.secret.yaml`, etc.  
   - Secrets must be generated at runtime or injected via environment variables / vault / secrets manager.  
   - Rationale: Git history is forever — a leaked secret in a commit can compromise the entire ecosystem.

3. **Never expose API keys, tokens, or credentials in frontend JavaScript**  
   - All sensitive operations (tenant management, provisioning, billing) happen server-side via signed API calls.  
   - Frontend only uses short-lived, scoped JWTs for authentication.  
   - Rationale: Browser storage / network inspection makes client-side secrets trivial to steal.

4. **The gateway (reverse proxy) is the only process that speaks HTTP/HTTPS to the Internet**  
   - Nginx / Caddy / Traefik listens on 80/443 → proxies to internal localhost ports (:2092, :2094, etc.).  
   - No WCP360 daemon or module binds directly to public interfaces.  
   - Rationale: Single point of entry → easier TLS termination, WAF, rate limiting, and firewall rules.

5. **Core daemon must drop root privileges immediately after bootstrap**  
   - Use PAM for one-time root bootstrap (first login).  
   - Immediately switch to non-root user (`wcp360:wcp360`) using `setuid` / `syscall` or systemd `User=`.  
   - Rationale: No persistent root execution → drastically reduces impact of any compromise.

6. **All internal module ↔ core communication uses Unix sockets or signed API calls**  
   - Preferred: Unix domain sockets (`/run/wcp360/module.sock`) with `SO_PEERCRED` for authentication.  
   - Alternative: localhost TCP with mTLS or JWT-signed requests.  
   - Rationale: No plaintext over network → prevents eavesdropping or injection between components.

7. **Provide SELinux / AppArmor profiles for every binary**  
   - Ship default profiles for `wcpd`, module binaries, and helpers.  
   - Enforce confinement (no unexpected file/network access).  
   - Rationale: Mandatory access control catches bugs/exploits that bypass other layers.

8. **Audit trail must be append-only & cryptographically signed where possible**  
   - Use an append-only file or DB table with immutability guarantees.  
   - Optional: sign each entry with HMAC or public-key signature.  
   - Rationale: Tamper-proof history for compliance, forensics, and trust.

### Summary – What This Structure Gives You

- **Clean, standard Linux layout** (FHS compliant)  
- **Trivial complete uninstall**: `rm -rf /opt/wcp360 /etc/wcp360 /var/lib/wcp360 /var/log/wcp360`  
- **Cluster-ready foundation** (agent + shared token / shared storage)  
- **Much easier commercial packaging & licensing** later (deb/rpm, Docker images)  
- **Native zero-trust & strong isolation principles**  
- **Preparation for immutable upgrades & rollback** (atomic /opt/wcp360 symlinks or containers)

These rules are **non-negotiable**.  
Violating any of them invalidates core security guarantees.  
All contributors must respect them from day one.

See also: [ARCHITECTURE.md](ARCHITECTURE.md) | [SECURITY.md](SECURITY.md) | [INSTALLATION.md](INSTALLATION.md)



