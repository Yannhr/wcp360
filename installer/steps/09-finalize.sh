# ==============================================================================
# WCP360 Installation Summary
# ------------------------------------------------------------------------------
# Displays installation results.
#
# Shows:
#   - Login URL to the control panel of WCP360
#   - Login as root server control panel credentials : http://<IP_ADDRESS>:8080/admin
#   - login as client control panel credentials : http://<IP_ADDRESS>:8080/client
#   - API endpoint
#   - Credential file location
#   - Log file path
#
# No system modifications performed.
# ==============================================================================
IP=$(hostname -I | awk '{print $1}')
echo ""
echo "Panel URL: http://$IP"
echo "Database credentials stored in /root/.wcp360-db"
echo "Logs: /var/log/wcp360-install.log"
