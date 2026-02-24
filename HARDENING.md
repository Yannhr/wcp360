<h1>🔐 WCP360 Hardening Guide</h1>
This document describes security best practices for deploying WCP360 in production environments.

WCP360 is designed with security-first principles, but proper system hardening is mandatory for real-world deployments.

<hr />

<h2>1. Runtime Security</h2>
<h3>Run as Dedicated User</h3>
Never run WCP360 as root.
<pre><code>useradd -r -s /usr/sbin/nologin wcp360
chown -R wcp360:wcp360 /opt/wcp360</code></pre>
<h3>Systemd Hardening</h3>
<pre><code>NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=strict
ProtectHome=true
ProtectControlGroups=true
ProtectKernelModules=true
ProtectKernelTunables=true
RestrictAddressFamilies=AF_INET AF_INET6
RestrictNamespaces=true
LockPersonality=true
MemoryDenyWriteExecute=true</code></pre>

<hr />

<h2>2. Network Security</h2>
<h3>Firewall</h3>
Allow only required ports:
<ul>
 	<li>80 (HTTP)</li>
 	<li>443 (HTTPS)</li>
 	<li>22 (SSH, restricted)</li>
 	<li>25 / 465 / 587 (if mail enabled)</li>
</ul>
<pre><code>ufw allow 80
ufw allow 443</code></pre>
<h3>TLS Enforcement</h3>
<ul>
 	<li>Use valid TLS certificates (e.g., Let's Encrypt)</li>
 	<li>Disable TLS 1.0 / 1.1</li>
 	<li>Enforce HTTPS redirection</li>
 	<li>Enable HSTS</li>
</ul>

<hr />

<h2>3. Authentication Security</h2>
<h3>Password Policy</h3>
<ul>
 	<li>Minimum 12 characters</li>
 	<li>Uppercase and lowercase letters</li>
 	<li>At least one number</li>
 	<li>At least one symbol</li>
 	<li>Block common passwords</li>
</ul>
<h3>Optional 2FA</h3>
Strongly recommended for:
<ul>
 	<li>System administrators</li>
 	<li>Resellers</li>
 	<li>API access accounts</li>
</ul>

<hr />

<h2>4. API Protection</h2>
<ul>
 	<li>Enable rate limiting</li>
 	<li>Validate JSON payloads strictly</li>
 	<li>Reject oversized request bodies</li>
 	<li>Use structured error responses</li>
 	<li>Use signed API tokens</li>
 	<li>Rotate API tokens periodically</li>
</ul>

<hr />

<h2>5. Database Security</h2>
<ul>
 	<li>Use strong database credentials</li>
 	<li>Restrict database access to localhost</li>
 	<li>Disable remote root login</li>
 	<li>Rotate database passwords regularly</li>
 	<li>Use separate database users per tenant when possible</li>
</ul>

<hr />

<h2>6. File System Isolation</h2>
<ul>
 	<li>Separate tenant home directories</li>
 	<li>Enforce strict permissions (750 or stricter)</li>
 	<li>Prevent symlink traversal</li>
 	<li>Restrict executable permissions</li>
 	<li>Validate file uploads</li>
 	<li>Scan uploads if malware module is enabled</li>
</ul>

<hr />

<h2>7. Web Server Hardening (Nginx)</h2>
<ul>
 	<li>Disable server_tokens</li>
 	<li>Enable rate limiting</li>
 	<li>Configure compression carefully</li>
 	<li>Protect against request flooding</li>
 	<li>Enforce strict MIME type handling</li>
 	<li>Disable directory listing unless required</li>
</ul>

<hr />

<h2>8. Logging &amp; Audit</h2>
<ul>
 	<li>Enable append-only audit logs</li>
 	<li>Store logs outside the web root</li>
 	<li>Rotate logs regularly</li>
 	<li>Monitor suspicious activity</li>
 	<li>Forward logs to centralized logging systems</li>
 	<li>Protect log integrity (hash chaining recommended)</li>
</ul>

<hr />

<h2>9. Backup Hardening</h2>
<ul>
 	<li>Encrypt backups</li>
 	<li>Store off-site copies</li>
 	<li>Protect object storage credentials</li>
 	<li>Restrict backup access</li>
 	<li>Test restore procedures regularly</li>
</ul>

<hr />

<h2>10. OS-Level Recommendations</h2>
<ul>
 	<li>Keep OS updated</li>
 	<li>Enable automatic security patches</li>
 	<li>Use fail2ban</li>
 	<li>Use SELinux or AppArmor if applicable</li>
 	<li>Disable unused services</li>
 	<li>Disable password-based SSH login (use keys)</li>
</ul>

<hr />

<h2>11. Supply Chain Security</h2>
<ul>
 	<li>Use Go module verification</li>
 	<li>Run govulncheck regularly</li>
 	<li>Enable Dependabot</li>
 	<li>Sign releases</li>
 	<li>Verify third-party modules</li>
 	<li>Pin dependency versions</li>
</ul>

<hr />

<h2>🚨 Incident Response</h2>
<ol>
 	<li>Isolate the server immediately</li>
 	<li>Review logs and audit trails</li>
 	<li>Rotate all credentials</li>
 	<li>Reissue SSL certificates</li>
 	<li>Notify affected users</li>
 	<li>Apply security patches immediately</li>
 	<li>Investigate root cause before restoring services</li>
</ol>

<hr />

<strong>Following these hardening practices significantly reduces the attack surface of WCP360 in production environments.</strong>

&nbsp;
