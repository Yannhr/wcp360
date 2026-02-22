require_root() {
  [[ "$EUID" -eq 0 ]] || { echo "Run as root"; exit 1; }
}

detect_os() {
  source /etc/os-release
  [[ "$ID" == "ubuntu" || "$ID" == "debian" ]] || exit 1
}

check_internet() {
  ping -c1 8.8.8.8 >/dev/null 2>&1 || exit 1
}
