#!/usr/bin/env bash
set -e

ufw allow OpenSSH || true
ufw allow 80 || true
ufw allow 443 || true
ufw --force enable || true

systemctl enable fail2ban
systemctl start fail2ban
