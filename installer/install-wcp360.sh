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

#!/usr/bin/env bash
# ==============================================================================
# WCP360 Enterprise Bootstrap Installer
# Professional Production-Grade Installer
# ==============================================================================

set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROFILE="full"
AUTO=false
DOMAIN=""
SERVER_IP=""
ADMIN_PASS=""

# =========================
# Colors
# =========================
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

# =========================
# Usage
# =========================
usage() {
  cat <<EOF
Usage: sudo $(basename "$0") [options]

Options:
  --profile=NAME     minimal | full (default: full)
  --auto             Non-interactive mode
  --domain=DOMAIN    Primary domain
  --help             Show this help
EOF
  exit 0
}

# =========================
# Parse Arguments
# =========================
while [[ $# -gt 0 ]]; do
  case $1 in
    --profile=*) PROFILE="${1#*=}" ;;
    --auto)      AUTO=true ;;
    --domain=*)  DOMAIN="${1#*=}" ;;
    --help)      usage ;;
    *) echo "Unknown option: $1"; usage ;;
  esac
  shift
done

[[ $EUID -ne 0 ]] && { echo -e "${RED}Must run as root${RESET}"; exit 1; }

# =========================
# ASCII Banner
# =========================
clear
echo -e "${BLUE}"
cat << "EOF"
 __          _______ _____    ____    __   ___  
 \ \        / / ____|  __ \  |___ \  / /  / _ \ 
  \ \  /\  / / |    | |__) |   __) |/ /_ | | | |
   \ \/  \/ /| |    |  ___/   |__ <| '_ \| | | |
    \  /\  / | |____| |       ___) | (_) | |_| |
     \/  \/   \_____|_|      |____/ \___/ \___/    

        WCP 360 Enterprise Server Installer
EOF
echo -e "${RESET}"

echo -e "${YELLOW}"
echo "This installer will prepare your server for WCP360."
echo ""
echo "Estimated installation time: 15 to 30 minutes."
echo "The server may restart services during installation."
echo -e "${RESET}"

# =========================
# Confirmation
# =========================
if [ "$AUTO" = false ]; then
  read -rp "ARE YOU READY TO START INSTALLATION? (YES/no): " CONFIRM
  if [[ "$CONFIRM" != "YES" ]]; then
    echo "Installation aborted."
    exit 0
  fi
fi

# =========================
# Detect IP
# =========================
SERVER_IP=$(hostname -I | awk '{print $1}')
echo -e "${GREEN}Detected Server IP:${RESET} $SERVER_IP"

# =========================
# Ask Domain
# =========================
if [[ -z "$DOMAIN" ]]; then
  if [ "$AUTO" = false ]; then
    read -rp "Enter your domain (or press Enter to use IP): " DOMAIN
  fi
fi

if [[ -z "$DOMAIN" ]]; then
  DOMAIN="$SERVER_IP"
fi

echo -e "${GREEN}Using domain:${RESET} $DOMAIN"

# =========================
# Set Hostname
# =========================
echo -e "${BLUE}Configuring hostname...${RESET}"
hostnamectl set-hostname "$DOMAIN"
echo "127.0.0.1   $DOMAIN" >> /etc/hosts

# =========================
# Load Core Modules
# =========================
source "$BASE_DIR/utils/logger.sh"     || exit 1
source "$BASE_DIR/utils/system.sh"     || exit 1
source "$BASE_DIR/utils/idempotent.sh" || exit 1
source "$BASE_DIR/bootstrap/state-machine.sh" || exit 1
source "$BASE_DIR/rollback/rollback.sh" || exit 1
source "$BASE_DIR/utils/password.sh" || exit 1

init_logger
detect_os
check_internet
init_state

STEPS_FILE="$BASE_DIR/profiles/${PROFILE}.profile"
[[ ! -f "$STEPS_FILE" ]] && { echo "Profile not found"; exit 1; }

trap 'echo -e "${RED}Installation failed. Rolling back...${RESET}"; rollback_all; exit 1' ERR

# =========================
# Start Installation
# =========================
echo -e "${BLUE}Starting installation...${RESET}"

while IFS= read -r STEP || [[ -n "$STEP" ]]; do
  [[ -z "$STEP" ]] && continue
  echo -e "${YELLOW}Executing step:${RESET} $STEP"
  set_state "$STEP"
  bash "$BASE_DIR/steps/$STEP" "$AUTO" "$DOMAIN"
done < "$STEPS_FILE"

# =========================
# Generate Admin Password
# =========================
ADMIN_PASS=$(generate_password)
echo "$ADMIN_PASS" > /root/.wcp360-admin
chmod 600 /root/.wcp360-admin

# =========================
# Completion Message
# =========================
clear
echo -e "${GREEN}"
cat <<EOF
=====================================================
            WCP360 INSTALLATION COMPLETE
=====================================================

Access your Control Panel:

URL: https://$DOMAIN
Fallback: http://$SERVER_IP

Admin Username: root
Admin Password: $ADMIN_PASS

Installation Log:
  /var/log/wcp360-install.json

Database Credentials:
  /root/.wcp360-db

=====================================================
EOF
echo -e "${RESET}"

echo "Your server is now ready."