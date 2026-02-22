#!/usr/bin/env bash
set -euo pipefail

VERSION="3.0.0"
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$BASE_DIR/lib"
STEPS_DIR="$BASE_DIR/steps"

PROFILE="full"
AUTO=false
LOG_FILE="/var/log/wcp360-install.log"

for arg in "$@"; do
  case $arg in
    --profile=*) PROFILE="${arg#*=}" ;;
    --auto) AUTO=true ;;
  esac
done

source "$LIB_DIR/ui.sh"
source "$LIB_DIR/logger.sh"
source "$LIB_DIR/system.sh"
source "$LIB_DIR/progress.sh"
source "$LIB_DIR/profiles.sh"

init_logger "$LOG_FILE"
require_root
check_os
check_internet

print_banner "WCP360 Installer v$VERSION"
print_info "Profile: $PROFILE"

if [ "$AUTO" = false ]; then
  read -rp "Proceed? (y/n): " CONFIRM
  [[ "$CONFIRM" == "y" ]] || exit 0
fi

STEPS=($(get_profile_steps "$PROFILE"))
TOTAL=${#STEPS[@]}
COUNT=0

for STEP in "${STEPS[@]}"; do
  COUNT=$((COUNT+1))
  print_step "$COUNT" "$TOTAL" "$STEP"
  bash "$STEPS_DIR/$STEP"
  progress_bar "$COUNT" "$TOTAL"
  print_success "$STEP completed"
done

print_success "Installation completed successfully"
