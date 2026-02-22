# ==============================================================================
# WCP360 JSON Logging Utility
# ------------------------------------------------------------------------------
# ROLE IN WCP360 ARCHITECTURE:
#   Provides structured JSON logging for:
#     - Audit trails
#     - Debugging
#     - Security analysis
#
# OUTPUT:
#   /var/log/wcp360-install.json (restricted permissions)
# ==============================================================================

init_logger() {
  mkdir -p /var/log
  touch /var/log/wcp360-install.json
  chmod 600 /var/log/wcp360-install.json
}

log_json() {
  echo "{\"timestamp\":\"$(date -Iseconds)\",\"level\":\"$1\",\"message\":\"$2\"}" \
  >> /var/log/wcp360-install.json
}
