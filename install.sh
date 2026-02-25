#!/usr/bin/env bash
# install.sh - Minimal WCP360 installer (dev/skeleton version)
# Usage: curl -fsSL https://raw.githubusercontent.com/Webcontrolpanel360/wcp360/feature/minimal-install-script/install.sh | sudo bash
#        or ./install.sh (as root)

set -euo pipefail

# ──────────────────────────────────────────────────────────────────────────────
# Colors & logging
# ──────────────────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1" >&2; exit 1; }

# ──────────────────────────────────────────────────────────────────────────────
# Preflight checks
# ──────────────────────────────────────────────────────────────────────────────
if [[ $EUID -ne 0 ]]; then
    log_error "This script must be run as root (sudo)."
fi

if ! command -v go &> /dev/null; then
    log_error "Go is not installed. Please install Go >= 1.23 (https://go.dev/dl/)"
fi

GO_VERSION=$(go version | cut -d' ' -f3 | sed 's/go//')
if [[ "${GO_VERSION}" < "1.23" ]]; then
    log_warn "Go version ${GO_VERSION} detected — WCP360 targets Go 1.23+"
fi

# Check OS (basic support for Tier 1: Ubuntu/Debian)
if ! grep -qiE 'ubuntu|debian' /etc/os-release; then
    log_warn "This installer is optimized for Ubuntu/Debian (Tier 1). Proceed with caution."
fi

log_info "Starting WCP360 minimal installation (skeleton mode)"

# ──────────────────────────────────────────────────────────────────────────────
# Create system user & group
# ──────────────────────────────────────────────────────────────────────────────
if ! id "wcp360" &>/dev/null; then
    log_info "Creating system user/group: wcp360"
    useradd -r -s /usr/sbin/nologin -d /nonexistent -m -U wcp360
else
    log_info "User wcp360 already exists"
fi

# ──────────────────────────────────────────────────────────────────────────────
# Directory structure (strict FHS from ARCHITECTURE.md)
# ──────────────────────────────────────────────────────────────────────────────
DIRS=(
    "/opt/wcp360/bin"
    "/etc/wcp360"
    "/var/lib/wcp360"
    "/var/log/wcp360"
    "/srv/www"          # future client sites
)

for dir in "${DIRS[@]}"; do
    if [[ ! -d "$dir" ]]; then
        log_info "Creating directory: $dir"
        mkdir -p "$dir"
        chown -R wcp360:wcp360 "$dir"
        chmod -R 750 "$dir"
    fi
done

# ──────────────────────────────────────────────────────────────────────────────
# Build & install the binary (from current branch/repo)
# In production: download release; here: assume local dev or clone
# ──────────────────────────────────────────────────────────────────────────────
log_info "Building WCP360 binary from source..."

# For dev: build from current dir (if cloned)
if [[ -f "cmd/wcp360/main.go" && -f "go.mod" ]]; then
    go build -o /opt/wcp360/bin/wcp360 ./cmd/wcp360
else
    # Fallback: clone the feature branch and build
    TMP_DIR=$(mktemp -d)
    git clone --depth 1 --branch feature/initial-go-skeleton-with-cobra \
        https://github.com/Webcontrolpanel360/wcp360.git "$TMP_DIR"
    pushd "$TMP_DIR" >/dev/null
    go mod tidy
    go build -o /opt/wcp360/bin/wcp360 ./cmd/wcp360
    popd >/dev/null
    rm -rf "$TMP_DIR"
fi

if [[ ! -x "/opt/wcp360/bin/wcp360" ]]; then
    log_error "Failed to build/install binary"
fi

chown wcp360:wcp360 /opt/wcp360/bin/wcp360
chmod 755 /opt/wcp360/bin/wcp360

log_info "Binary installed at /opt/wcp360/bin/wcp360"

# ──────────────────────────────────────────────────────────────────────────────
# Basic test
# ──────────────────────────────────────────────────────────────────────────────
log_info "Testing CLI..."
su -s /bin/bash wcp360 -c "/opt/wcp360/bin/wcp360 version" || log_warn "CLI test failed (expected in skeleton mode)"

# ──────────────────────────────────────────────────────────────────────────────
# Next steps (placeholder for future: systemd, db init, etc.)
# ──────────────────────────────────────────────────────────────────────────────
cat <<EOF

${GREEN}WCP360 skeleton installed successfully!${NC}

Next manual steps (to implement later):
- Create systemd service: /etc/systemd/system/wcp360.service
- Initialize internal DB: /opt/wcp360/bin/wcp360 setup
- Add first admin: /opt/wcp360/bin/wcp360 admin create admin
- Configure Nginx/Podman/cgroups...

Test now:
  /opt/wcp360/bin/wcp360 --help
  /opt/wcp360/bin/wcp360 version

Full docs: https://github.com/Webcontrolpanel360/wcp360
EOF

exit 0