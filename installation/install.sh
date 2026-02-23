#!/usr/bin/env bash
set -Eeuo pipefail

# ======================================================== #
#
# WCP360 Installation Routine
# OS detection wrapper (Debian/Ubuntu)
#
# It downloads and runs an OS-specific installer from:
#   https://raw.githubusercontent.com/Yannhr/wcp360/main/installation/
#
# Defaults to installer names:
#   - install-debian.sh
#   - install-ubuntu.sh
#
# Override via env if your filenames differ.
#
# ======================================================== #

log()  { echo -e "[ * ] $*"; }
warn() { echo -e "[ ! ] $*" >&2; }
die()  { echo -e "[ x ] $*" >&2; exit 1; }

usage() {
  cat <<'EOF'
Usage:
  sudo bash installation/install.sh [--force] [--] [installer-args...]

Options:
  --force, -f    Skip user/group pre-checks (if enabled below)
  -h, --help     Show this help

Environment overrides:
  WCP360_REPO_RAW_BASE_URL   Default:
    https://raw.githubusercontent.com/Yannhr/wcp360/main/installation

  WCP360_INSTALLER_URL       If set, skips OS-based naming and uses this exact URL.

  WCP360_INSTALLER_NAME      If set, uses this filename under WCP360_REPO_RAW_BASE_URL.
    Example: WCP360_INSTALLER_NAME="wcp360-install-ubuntu.sh"

  WCP360_SYSTEM_USER         Optional pre-check user (default: wcp360)
  WCP360_SYSTEM_GROUP        Optional pre-check group (default: wcp360)
EOF
}

# ---- Root check ----
if [ "$(id -u)" -ne 0 ]; then
  die "This script must be run as root (use sudo)."
fi

# ---- Args ----
FORCE=0
PASSTHRU=()

while [ $# -gt 0 ]; do
  case "$1" in
    --force|-f) FORCE=1; shift ;;
    -h|--help) usage; exit 0 ;;
    --) shift; PASSTHRU+=("$@"); break ;;
    *) PASSTHRU+=("$1"); shift ;;
  esac
done

# ---- Optional: user/group pre-checks ----
# If your installer creates a different system user/group, override via env.
WCP360_SYSTEM_USER="${WCP360_SYSTEM_USER:-wcp360}"
WCP360_SYSTEM_GROUP="${WCP360_SYSTEM_GROUP:-wcp360}"

if [ "$FORCE" -eq 0 ]; then
  if getent passwd "$WCP360_SYSTEM_USER" >/dev/null 2>&1; then
    die "System user '$WCP360_SYSTEM_USER' already exists.
Re-run with --force to skip this check."
  fi

  if getent group "$WCP360_SYSTEM_GROUP" >/dev/null 2>&1; then
    die "System group '$WCP360_SYSTEM_GROUP' already exists.
Re-run with --force to skip this check."
  fi
fi

# ---- OS detection ----
if [ ! -r /etc/os-release ]; then
  die "Cannot detect OS (missing /etc/os-release)."
fi

# shellcheck disable=SC1091
. /etc/os-release

OS_ID="${ID:-}"
OS_VERSION_ID="${VERSION_ID:-}"

OS_ID="${OS_ID//\"/}"
OS_VERSION_ID="${OS_VERSION_ID//\"/}"

# Debian fallback if VERSION_ID is empty
if [ "$OS_ID" = "debian" ] && [ -z "$OS_VERSION_ID" ] && [ -r /etc/debian_version ]; then
  OS_VERSION_ID="$(grep -oE '^[0-9]+' /etc/debian_version | head -n1 || true)"
fi

SUPPORTED=0
case "$OS_ID" in
  ubuntu)
    case "$OS_VERSION_ID" in
      20.04|22.04|24.04) SUPPORTED=1 ;;
    esac
    ;;
  debian)
    case "$OS_VERSION_ID" in
      11|12) SUPPORTED=1 ;;
    esac
    ;;
esac

no_support_message() {
  cat >&2 <<EOF
****************************************************
Your OS is not supported by this WCP360 installer wrapper.
Detected: $OS_ID $OS_VERSION_ID

Supported (adjust if your project supports more):
  - Debian 11, 12
  - Ubuntu 20.04, 22.04, 24.04 LTS
****************************************************
EOF
  exit 1
}

if [ "$SUPPORTED" -ne 1 ]; then
  no_support_message
fi

# ---- Ensure UTF-8 locale ----
ensure_utf8_locale() {
  if locale 2>/dev/null | grep -qi 'utf-8'; then
    return 0
  fi

  log "Enabling UTF-8 locale via C.UTF-8"
  if command -v locale-gen >/dev/null 2>&1; then
    locale-gen C.UTF-8 >/dev/null 2>&1 || warn "locale-gen C.UTF-8 failed (continuing)."
  fi

  if command -v update-locale >/dev/null 2>&1; then
    update-locale LANG=C.UTF-8 >/dev/null 2>&1 || warn "update-locale failed (continuing)."
  fi

  export LANG=C.UTF-8
}
ensure_utf8_locale

# ---- Build installer URL ----
REPO_RAW_BASE_URL="${WCP360_REPO_RAW_BASE_URL:-https://raw.githubusercontent.com/Yannhr/wcp360/main/installation}"

# Default naming convention (change if your repo uses different names):
#   install-debian.sh
#   install-ubuntu.sh
DEFAULT_INSTALLER_NAME="install-${OS_ID}.sh"

INSTALLER_NAME="${WCP360_INSTALLER_NAME:-$DEFAULT_INSTALLER_NAME}"

# If user provides a full URL, use it
INSTALLER_URL="${WCP360_INSTALLER_URL:-${REPO_RAW_BASE_URL}/${INSTALLER_NAME}}"

# ---- Download + execute ----
TMP_DIR="$(mktemp -d)"
cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT

INSTALLER_PATH="${TMP_DIR}/${INSTALLER_NAME}"

download_installer() {
  if command -v wget >/dev/null 2>&1; then
    wget -q "$INSTALLER_URL" -O "$INSTALLER_PATH" && return 0
  fi
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$INSTALLER_URL" -o "$INSTALLER_PATH" && return 0
  fi
  die "Neither wget nor curl is installed. Please install one and retry."
}

log "Downloading WCP360 installer: $INSTALLER_URL"
if ! download_installer; then
  die "Download failed: $INSTALLER_URL"
fi

chmod +x "$INSTALLER_PATH"

log "Running OS-specific installer: $INSTALLER_NAME"
# shellcheck disable=SC2086
bash "$INSTALLER_PATH" ${PASSTHRU[@]+"${PASSTHRU[@]}"}

log "WCP360 installation wrapper finished."