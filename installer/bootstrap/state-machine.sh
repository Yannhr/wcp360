# ==============================================================================
# WCP360 Installation State Machine
# ------------------------------------------------------------------------------
# ROLE IN WCP360 ARCHITECTURE:
#   Maintains installation progress state.
#   Enables crash recovery and resumable deployments.
#
# FUNCTIONALITY:
#   - Stores current installation step in JSON format
#   - Allows safe restart after interruption
# ==============================================================================

STATE_FILE="/var/lib/wcp360/install-state.json"

init_state() {
  mkdir -p /var/lib/wcp360
  echo '{"current_step":"none"}' > "$STATE_FILE"
}

set_state() {
  echo "{\"current_step\":\"$1\"}" > "$STATE_FILE"
}
