IP=$(hostname -I | awk '{print $1}')
echo "Access your server at: http://$IP"
