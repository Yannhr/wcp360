#!/usr/bin/env bash
set -euo pipefail

VERSION="6.0.0"
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STEPS_DIR="$BASE_DIR/steps"
LOG_FILE="/var/log/wcp360-install.log"

log() {
  echo "$(date '+%F %T') - $1" | tee -a "$LOG_FILE"
}

# ===============================
# Checks
# ===============================
[ "$EUID" -eq 0 ] || { echo "Run as root"; exit 1; }
grep -qiE "ubuntu|debian" /etc/os-release || { echo "Unsupported OS"; exit 1; }

clear
echo "================================================="
echo "      WCP360 INSTALLER v$VERSION"
echo "================================================="
echo ""

read -rp "Proceed with installation? (y/n): " CONFIRM
[[ "$CONFIRM" == "y" ]] || exit 0

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
echo " Installation Completed Successfully"
echo " Open your browser: http://$IP"
echo "================================================="