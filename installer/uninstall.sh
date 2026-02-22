#!/usr/bin/env bash
set -e

echo "Removing WCP360..."

systemctl stop nginx || true
apt remove --purge -y nginx
rm -rf /var/www/wcp360
rm -f /etc/nginx/sites-enabled/wcp360
rm -f /etc/nginx/sites-available/wcp360

echo "WCP360 removed."
