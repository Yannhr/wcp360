# ==============================================================================
# WCP360 Step 01 - System Preparation
# ------------------------------------------------------------------------------
# ROLE:
#   Prepares host machine for WCP360 deployment.
#
# ACTIONS:
#   - Install core dependencies
#   - Configure base services
#   - Create system user for sandboxed execution
# ==============================================================================
apt update -y
install_if_missing nginx
install_if_missing mariadb-server
install_if_missing php-fpm
install_if_missing ufw
install_if_missing fail2ban
echo "Updating system..."
sudo apt update -y
sudo apt upgrade -y

echo "Installing Nginx..."
sudo apt install nginx -y

echo "Enabling Nginx..."
sudo systemctl enable nginx
sudo systemctl start nginx

echo "Opening firewall..."
sudo ufw allow 'Nginx Full'

echo "Nginx installation completed!"

useradd -r -s /usr/sbin/nologin wcp || true
mkdir -p /opt/wcp360
