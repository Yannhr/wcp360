ufw default deny incoming
ufw allow OpenSSH
ufw allow 80
ufw allow 443
ufw --force enable

systemctl enable fail2ban
