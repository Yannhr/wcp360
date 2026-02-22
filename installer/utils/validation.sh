validate_service() {
  systemctl is-active --quiet "$1" || {
    echo "Service $1 is not running"
    exit 1
  }
}
