#!/usr/bin/env bash
#!/usr/bin/env bash
# ==============================================================================
# WCP360 Bootstrap Installer
# ------------------------------------------------------------------------------
# Version: 1.0.0
# Description:
#   Main orchestration entrypoint for WCP360 installation.
#   Executes modular installation phases in a strict, controlled sequence.
#
# Responsibilities:
#   - Load utilities
#   - Enforce root execution
#   - Validate OS compatibility
#   - Execute atomic installation steps
#   - Trigger rollback on failure
#   - Log installation progress
#
# Security:
#   - Uses set -euo pipefail
#   - No plaintext credentials
#   - Centralized logging
#   - Mandatory reverse proxy enforcement
#
# WARNING:
#   This script modifies system configuration and installs services.
#   Use only on fresh production servers.
#
# Project: WCP360
# License: See LICENSE file
# ==============================================================================
set -euo pipefail

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG_FILE="/var/log/wcp360-install.log"
STATE_FILE="/var/lib/wcp360/install-state.json"

source "$BASE_DIR/utils/ui.sh"
source "$BASE_DIR/utils/logger.sh"
source "$BASE_DIR/utils/system.sh"
source "$BASE_DIR/utils/state.sh"
source "$BASE_DIR/rollback/rollback.sh"

init_logger "$LOG_FILE"
init_state "$STATE_FILE"

print_banner "WCP360 Bootstrap v1.0"

require_root
detect_os
check_internet

STEPS=(
"preflight/01-preflight.sh"
"steps/02-system.sh"
"steps/03-core.sh"
"steps/04-api.sh"
"steps/05-panel.sh"
"steps/06-nginx.sh"
"steps/07-database.sh"
"steps/08-security.sh"
"steps/09-finalize.sh"
)

for STEP in "${STEPS[@]}"; do
  echo "Running $STEP"
  bash "$BASE_DIR/$STEP"
done

print_success "Installation Completed"
