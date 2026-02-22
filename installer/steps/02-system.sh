apt install -y nginx mariadb-server php-fpm certbot ufw fail2ban
useradd -r -s /usr/sbin/nologin wcp || true
mkdir -p /opt/wcp360/bin
mkdir -p /var/log/wcp360
chown -R wcp:wcp /opt/wcp360
