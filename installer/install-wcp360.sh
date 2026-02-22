#!/usr/bin/env bash
# ==============================================================================
# WCP360 Enterprise Bootstrap Installer
# ------------------------------------------------------------------------------
# ROLE IN WCP360 ARCHITECTURE:
#   This script is the main orchestration entrypoint of the WCP360 platform.
#   It controls the full installation lifecycle using:
#     - Profile-driven execution (minimal / full)
#     - Step-based modular architecture
#     - Stateful crash recovery
#     - Automatic rollback on failure
#
# RESPONSIBILITIES:
#   - Parse CLI arguments
#   - Validate execution environment
#   - Load selected installation profile
#   - Execute each installation step sequentially
#   - Track current state for resumability
#   - Enforce secure execution model
#
# SECURITY DESIGN:
#   - Strict mode (set -euo pipefail)
#   - Root execution required
#   - JSON structured logging
#   - Automatic rollback trap
#
# USAGE:
#   sudo bash install-wcp360.sh --profile=full --auto --domain=example.com
# ==============================================================================

set -euo pipefail

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PROFILE="full"
AUTO=false
DOMAIN=""

# ------------------------------------------------------------------------------
# CLI Argument Parsing
# ------------------------------------------------------------------------------
for arg in "$@"; do
  case $arg in
    --profile=*) PROFILE="${arg#*=}" ;;
    --auto) AUTO=true ;;
    --domain=*) DOMAIN="${arg#*=}" ;;
  esac
done

# ------------------------------------------------------------------------------
# Load Core Framework Modules
# ------------------------------------------------------------------------------
source "$BASE_DIR/utils/logger.sh"
source "$BASE_DIR/utils/system.sh"
source "$BASE_DIR/utils/idempotent.sh"
source "$BASE_DIR/bootstrap/state-machine.sh"
source "$BASE_DIR/rollback/rollback.sh"

# ------------------------------------------------------------------------------
# Pre-Installation Validation
# ------------------------------------------------------------------------------
init_logger
require_root
detect_os
check_internet
init_state

STEPS_FILE="$BASE_DIR/profiles/$PROFILE.profile"

# ------------------------------------------------------------------------------
# Step Execution Engine
# ------------------------------------------------------------------------------
while read -r STEP; do
  set_state "$STEP"
  bash "$BASE_DIR/steps/$STEP"
done < "$STEPS_FILE"

echo "WCP360 installation completed successfully."
