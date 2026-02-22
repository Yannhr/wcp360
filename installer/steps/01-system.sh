#!/usr/bin/env bash
set -e

apt update -y
apt upgrade -y

apt install -y \
curl wget git unzip \
ufw fail2ban \
nginx mariadb-server \
php php-fpm php-mysql php-curl php-mbstring

systemctl enable nginx
systemctl enable mariadb
systemctl enable php-fpm