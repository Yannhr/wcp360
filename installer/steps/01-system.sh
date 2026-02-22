apt update -y
apt upgrade -y
apt install -y curl wget git unzip ufw fail2ban nginx mariadb-server \
php8.2 php8.2-fpm php8.2-mysql certbot python3-certbot-nginx

systemctl enable nginx
systemctl enable mariadb
systemctl enable php8.2-fpm

register_rollback "apt remove -y nginx mariadb-server php8.2* certbot"
