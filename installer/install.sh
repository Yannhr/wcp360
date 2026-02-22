#!/usr/bin/env bash
set -e

echo "🚀 Installing WCP360..."

# Must run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Detect OS
if [ -f /etc/debian_version ]; then
  echo "Detected Debian/Ubuntu"
else
  echo "Unsupported OS"
  exit 1
fi

# Update system
apt update -y
apt upgrade -y

# Install dependencies
apt install -y curl wget gnupg lsb-release ca-certificates software-properties-common

# Install Nginx
apt install -y nginx

# Enable & start Nginx
systemctl enable nginx
systemctl start nginx

# Create web root
mkdir -p /var/www/wcp360
chown -R www-data:www-data /var/www/wcp360

# Default page
cat > /var/www/wcp360/index.html <<PAGE
<!DOCTYPE html>
<html>
<head>
  <title>Welcome to WCP360</title>
</head>
<body>
  <h1>WCP360 Installed Successfully 🚀</h1>
  <p>Your server is ready.</p>
</body>
</html>
PAGE

# Nginx site config
cat > /etc/nginx/sites-available/wcp360 <<CONF
server {
    listen 80;
    server_name _;
    root /var/www/wcp360;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
CONF

ln -sf /etc/nginx/sites-available/wcp360 /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

nginx -t
systemctl reload nginx

echo "✅ WCP360 Web Server installed."
echo "Visit http://your-server-ip"
