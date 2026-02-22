cp ../nginx/wcp360.conf /etc/nginx/sites-available/wcp360
ln -sf /etc/nginx/sites-available/wcp360 /etc/nginx/sites-enabled/
nginx -t
systemctl restart nginx
