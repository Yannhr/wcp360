# ==============================================================================
# WCP360 Server Hardening
# ------------------------------------------------------------------------------
# Applies production-level firewall and intrusion protection.
#
# Actions:
#   - UFW deny incoming
#   - Allow SSH, HTTP, HTTPS
#   - Enable Fail2Ban
#
# Security:
#   - Protect admin and API endpoints
#   - Prevent brute force attacks
# ==============================================================================
ufw default deny incoming
ufw allow OpenSSH
ufw allow 80
ufw allow 443
ufw --force enable
systemctl enable fail2ban
