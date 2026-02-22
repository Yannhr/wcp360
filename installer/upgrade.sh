#!/usr/bin/env bash
set -e

echo "Upgrading WCP360..."

apt update -y
apt upgrade -y

systemctl restart nginx

echo "Upgrade complete."
