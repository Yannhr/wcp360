#!/usr/bin/env bash
set -e

echo "Installing Nginx and PHP..."

apt install -y nginx php php-fpm php-mysql php-curl php-mbstring

systemctl enable nginx
systemctl enable php-fpm

mkdir -p /var/www/wcp360
chown -R www-data:www-data /var/www/wcp360

cat > /var/www/wcp360/index.php <<'PHP'
<?php
echo "<h1 style='color:#00d4ff;text-align:center;margin-top:100px;font-family:Arial'>🚀 WCP360 Installed Successfully</h1>";
echo "<p style='text-align:center'>PHP version: " . phpversion() . "</p>";
?>
PHP

cat > /etc/nginx/sites-available/wcp360 <<CONF
server {
    listen 80;
    server_name _;
    root /var/www/wcp360;
    index index.php;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php-fpm.sock;
    }

    server_tokens off;
}
CONF

ln -sf /etc/nginx/sites-available/wcp360 /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

nginx -t
systemctl restart nginx