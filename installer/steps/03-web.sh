apt install -y nginx php8.2 php8.2-fpm php8.2-mysql php8.2-curl php8.2-mbstring
systemctl enable nginx
systemctl enable php8.2-fpm
mkdir -p /var/www/wcp360
chown -R www-data:www-data /var/www/wcp360
