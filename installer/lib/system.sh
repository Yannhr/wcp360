require_root() {
  [ "$EUID" -eq 0 ] || { echo "Run as root"; exit 1; }
}

check_os() {
  grep -qiE "ubuntu|debian" /etc/os-release || {
    echo "Unsupported OS"; exit 1;
  }
}

check_internet() {
  ping -c1 8.8.8.8 >/dev/null 2>&1 || {
    echo "No internet connection"; exit 1;
  }
}

generate_password() {
  openssl rand -base64 32
}
