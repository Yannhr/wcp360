mkdir -p /var/www/wcp360
chown -R www-data:www-data /var/www/wcp360

cat > /var/www/wcp360/index.php <<PHP
<?php
echo "<h1 style='color:#00d4ff;text-align:center;margin-top:100px;font-family:Arial'>🚀 WCP360 Installed Successfully</h1>";
echo "<p style='text-align:center'>PHP is working.</p>";

\$conn = @new mysqli("localhost", "wcp360", "password", "wcp360");
if (\$conn->connect_error) {
    echo "<p style='text-align:center;color:red'>Database not yet configured.</p>";
} else {
    echo "<p style='text-align:center;color:green'>Database connection OK.</p>";
}
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
        fastcgi_pass unix:/run/php/php8.2-fpm.sock;
    }

    server_tokens off;
}
CONF

ln -sf /etc/nginx/sites-available/wcp360 /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

nginx -t
systemctl restart nginx
