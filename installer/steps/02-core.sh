mkdir -p /opt/wcp360/bin
touch /opt/wcp360/bin/wcpd
chown -R wcp:wcp /opt/wcp360

cp ../systemd/wcp360.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable wcp360
