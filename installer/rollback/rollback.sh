rollback() {
  echo "Critical failure. Rolling back..."
  systemctl stop wcp360 || true
  systemctl stop nginx || true
}
trap rollback ERR
