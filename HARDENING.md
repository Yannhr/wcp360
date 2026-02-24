# 🔐 WCP360 Hardening Guide

This document describes security best practices for deploying WCP360 in production environments.

WCP360 is designed with security-first principles, but proper system hardening is mandatory for real-world deployments.

---

# 1️⃣ Runtime Security

## Run as Dedicated User

Never run WCP360 as root.

Create a dedicated system user:

```bash
useradd -r -s /usr/sbin/nologin wcp360

Set ownership:

chown -R wcp360:wcp360 /opt/wcp360
Systemd Hardening

Recommended systemd service restrictions:

NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=strict
ProtectHome=true
ProtectControlGroups=true
ProtectKernelModules=true
ProtectKernelTunables=true
RestrictAddressFamilies=AF_INET AF_INET6
RestrictNamespaces=true
LockPersonality=true
MemoryDenyWriteExecute=true
2️⃣ Network Security
Firewall

Allow only required ports:

80 (HTTP)

443 (HTTPS)

22 (SSH, restricted)

25/465/587 (if mail enabled)

Use UFW or firewalld:

ufw allow 80
ufw allow 443

Restrict wcpanel access via IP allowlist if possible.

TLS Enforcement

Use Let's Encrypt or valid certificate

Disable insecure TLS versions

Enforce HTTPS redirection

Enable HSTS

3️⃣ Authentication Security
Password Policy

Minimum 12 characters

Require upper/lowercase

Require number + symbol

Prevent common passwords

Optional 2FA

2FA is optional but recommended for:

Admin users

Resellers

API access

4️⃣ API Protection

Enable rate limiting

Validate JSON payloads strictly

Reject oversized bodies

Enable structured error handling

Use signed API tokens

Rotate API tokens periodically

5️⃣ Database Security

Use strong DB credentials

Restrict DB to localhost

Disable remote root login

Regularly rotate passwords

Use separate DB user per tenant

6️⃣ File System Isolation

Separate user home directories

Enforce correct permissions (750 or stricter)

Prevent symlink traversal

Restrict executable permissions

Validate file uploads

7️⃣ Web Server Hardening (Nginx)

Disable server tokens

Enable rate limiting

Enable Brotli/Gzip carefully

Protect against request flooding

Set strict MIME type handling

8️⃣ Logging & Audit

Enable append-only audit logs

Store logs outside web root

Rotate logs regularly

Monitor suspicious activity

Forward logs to central logging if possible

9️⃣ Backup Hardening

Encrypt backups

Store off-site copies

Protect S3 credentials

Restrict backup access

Test restore procedures regularly

🔟 OS-Level Recommendations

Keep OS updated

Enable automatic security patches

Use fail2ban

Use SELinux or AppArmor (if applicable)

Disable unused services

Disable password SSH login (use keys)

1️⃣1️⃣ Supply Chain Security

Use Go module verification

Run govulncheck

Enable Dependabot

Sign releases

Verify third-party modules

🚨 Incident Response

If compromise is suspected:

Isolate server

Review logs

Rotate credentials

Reissue SSL certificates

Notify affected users

Apply patches immediately