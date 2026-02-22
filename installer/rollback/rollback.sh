# ==============================================================================
# WCP360 Rollback Handler
# ------------------------------------------------------------------------------
# Provides automatic recovery on critical installation failure.
#
# Responsibilities:
#   - Stop partially installed services
#   - Prevent broken runtime state
#
# Trigger:
#   Automatically executed via trap ERR
#
# Limitations:
#   - Does not revert OS-level package installation
#   - Focuses on service consistency
#
# Security:
#   - Ensures daemon not left exposed
# ==============================================================================
rollback() {
  echo "Critical failure. Rolling back..."
  systemctl stop wcp360 || true
  systemctl stop nginx || true
}
trap rollback ERR
