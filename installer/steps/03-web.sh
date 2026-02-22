#!/usr/bin/env bash
set -e

echo "Configuring web server..."

PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")
PHP_FPM_SOCKET="/run/php/php${PHP_VERSION}-fpm.sock"

mkdir -p /var/www/wcp360
chown -R www-data:www-data /var/www/wcp360

cat > /var/www/wcp360/index.php <<'PHP'
<?php
echo "<h1 style='text-align:center;margin-top:100px;color:#00d4ff;font-family:Arial'>🚀 WCP360 Installed Successfully</h1>";
echo "<p style='text-align:center'>PHP version: " . phpversion() . "</p>";
?>
PHP

mkdir -p /etc/nginx/sites-available
mkdir -p /etc/nginx/sites-enabled

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
        fastcgi_pass unix:${PHP_FPM_SOCKET};
    }

    server_tokens off;
}
CONF

ln -sf /etc/nginx/sites-available/wcp360 /etc/nginx/sites-enabled/wcp360
rm -f /etc/nginx/sites-enabled/default || true

nginx -t
systemctl restart nginx