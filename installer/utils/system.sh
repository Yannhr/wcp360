require_root() {
  [[ "$EUID" -eq 0 ]] || { echo "Run as root"; exit 1; }
}

detect_os() {
  source /etc/os-release
  if [[ "$ID" != "ubuntu" && "$ID" != "debian" ]]; then
    echo "Unsupported OS"; exit 1;
  fi
}

check_internet() {
  ping -c1 8.8.8.8 >/dev/null 2>&1 || {
    echo "No internet connection"; exit 1;
  }
}
