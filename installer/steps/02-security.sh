ufw default deny incoming
ufw allow OpenSSH
ufw allow 80
ufw allow 443
ufw --force enable
systemctl enable fail2ban
sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl reload ssh
