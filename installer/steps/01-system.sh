#!/usr/bin/env bash
set -e

echo "Updating system..."

apt update -y
apt upgrade -y

echo "Installing base packages..."

apt install -y \
curl wget git unzip \
ufw fail2ban \
nginx mariadb-server \
php php-fpm php-mysql php-curl php-mbstring

echo "Enabling services..."

systemctl enable nginx
systemctl enable mariadb
systemctl enable php-fpm