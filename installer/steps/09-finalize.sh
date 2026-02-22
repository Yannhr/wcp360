IP=$(hostname -I | awk '{print $1}')
echo ""
echo "Panel URL: http://$IP"
echo "Database credentials stored in /root/.wcp360-db"
echo "Logs: /var/log/wcp360-install.log"
