if [ "$PROFILE" = "minimal" ]; then
  echo "Skipping DB (minimal profile)"
  exit 0
fi

DB_PASS=$(openssl rand -base64 24)

mysql -e "CREATE DATABASE IF NOT EXISTS wcp360;"
mysql -e "CREATE USER IF NOT EXISTS 'wcp360'@'localhost' IDENTIFIED BY '$DB_PASS';"
mysql -e "GRANT ALL PRIVILEGES ON wcp360.* TO 'wcp360'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

sed -i "s/password/$DB_PASS/" /var/www/wcp360/index.php

echo "$DB_PASS" > /root/.wcp360-db
chmod 600 /root/.wcp360-db

register_rollback "mysql -e 'DROP DATABASE wcp360;'"
