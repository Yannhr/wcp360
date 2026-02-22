#!/usr/bin/env bash
set -euo pipefail

VERSION="5.1.0"
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STEPS_DIR="$BASE_DIR/steps"

PROFILE="full"
DOMAIN=""
LOG_FILE="/var/log/wcp360-install.log"
ROLLBACK_ACTIONS=()

for arg in "$@"; do
  case $arg in
    --profile=*) PROFILE="${arg#*=}" ;;
    --domain=*) DOMAIN="${arg#*=}" ;;
  esac
done

log() {
  echo "$(date '+%F %T') - $1" | tee -a "$LOG_FILE"
}

register_rollback() {
  ROLLBACK_ACTIONS+=("$1")
}

rollback() {
  log "⚠ Rolling back..."
  for (( i=${#ROLLBACK_ACTIONS[@]}-1 ; i>=0 ; i-- )); do
    eval "${ROLLBACK_ACTIONS[$i]}" || true
  done
}

trap rollback ERR

[ "$EUID" -eq 0 ] || { echo "Run as root"; exit 1; }
grep -qiE "ubuntu|debian" /etc/os-release || { echo "Unsupported OS"; exit 1; }

clear
echo "================================================="
echo "     WCP360 PROFESSIONAL INSTALLER v$VERSION"
echo "================================================="
echo "Profile: $PROFILE"
echo ""

read -rp "Proceed with installation? (y/n): " CONFIRM
[[ "$CONFIRM" == "y" ]] || exit 0

export PROFILE
export DOMAIN
export LOG_FILE
export -f log
export -f register_rollback

TOTAL=$(ls "$STEPS_DIR"/*.sh | wc -l)
COUNT=0

for STEP in $(ls "$STEPS_DIR"/*.sh | sort); do
  COUNT=$((COUNT+1))
  echo ""
  echo "-------------------------------------------------"
  echo " STEP $COUNT/$TOTAL - $(basename "$STEP")"
  echo "-------------------------------------------------"
  bash "$STEP"
done

IP=$(hostname -I | awk '{print $1}')
echo ""
echo "================================================="
echo "Installation Completed Successfully"
echo "Access: http://$IP"
[ -n "$DOMAIN" ] && echo "HTTPS: https://$DOMAIN"
echo "================================================="