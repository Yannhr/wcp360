# ==============================================================================
# WCP360 Logger Utility
# ------------------------------------------------------------------------------
# Handles centralized logging for the installer.
#
# Responsibilities:
#   - Initialize secure log file
#   - Redirect stdout/stderr to log
#   - Protect log file permissions (chmod 600)
#
# Log Location:
#   /var/log/wcp360-install.log
#
# Security:
#   - Sensitive data must never be echoed
# ==============================================================================
init_logger() {
  mkdir -p /var/log
  touch "$1"
  chmod 600 "$1"
  exec > >(tee -a "$1") 2>&1
}
