#!/usr/bin/env bash
set -e

if [ ! -d "/opt/wcp360/.git" ]; then
    git clone https://github.com/Yannhr/wcp360.git /opt/wcp360
else
    echo "Core already exists, skipping clone."
fi

chown -R www-data:www-data /opt/wcp360 || true
