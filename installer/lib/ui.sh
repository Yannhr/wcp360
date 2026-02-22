RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

print_banner() {
  echo -e "${BLUE}"
  echo "============================================"
  echo "  $1"
  echo "============================================"
  echo -e "${RESET}"
}

print_step() {
  echo -e "${YELLOW}"
  echo " ÉTAPE $1/$2 — $3"
  echo -e "${RESET}"
}

print_success() { echo -e "${GREEN}✔ $1${RESET}"; }
print_info() { echo -e "${BLUE}$1${RESET}"; }
