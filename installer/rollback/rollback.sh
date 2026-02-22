# ==============================================================================
# WCP360 Automatic Rollback Handler
# ------------------------------------------------------------------------------
# ROLE IN WCP360 ARCHITECTURE:
#   Ensures transactional installation.
#   Prevents partial deployment state.
#
# TRIGGER:
#   Automatically executed on any script error (trap ERR).
# ==============================================================================
rollback() {
  systemctl stop wcp360 || true
  systemctl stop nginx || true
  rm -rf /opt/wcp360 || true
}
trap rollback ERR
