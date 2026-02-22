# ==============================================================================
# WCP360 UI Utility
# ------------------------------------------------------------------------------
# Provides colored terminal output for installer feedback.
#
# Responsibilities:
#   - Display banners
#   - Display success/error messages
#   - Improve installation readability
#
# Security:
#   - No system modification
#
# Usage:
#   source utils/ui.sh
# ==============================================================================
GREEN="\e[32m"
RED="\e[31m"
BLUE="\e[34m"
RESET="\e[0m"

print_banner() {
  echo -e "${BLUE}"
  echo "==============================================="
  echo "  $1"
  echo "==============================================="
  echo -e "${RESET}"
}

print_success() { echo -e "${GREEN}✔ $1${RESET}"; }
print_error() { echo -e "${RED}✖ $1${RESET}"; }
