# ==============================================================================
# WCP360 Database Initialization
# ------------------------------------------------------------------------------
# Creates database and secure user credentials.
#
# Actions:
#   - Generate strong random password
#   - Create DB and user
#   - Store credentials securely
#
# Security:
#   - No hardcoded passwords
#   - Credentials stored in /root with chmod 600
# ==============================================================================
DB_PASS=$(openssl rand -base64 32)
mysql -e "CREATE DATABASE IF NOT EXISTS wcp360;"
mysql -e "CREATE USER IF NOT EXISTS 'wcp'@'localhost' IDENTIFIED BY '$DB_PASS';"
mysql -e "GRANT ALL PRIVILEGES ON wcp360.* TO 'wcp'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"
echo "DB_PASS=$DB_PASS" > /root/.wcp360-db
chmod 600 /root/.wcp360-db
