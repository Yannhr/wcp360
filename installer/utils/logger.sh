init_logger() {
  mkdir -p /var/log
  touch "$1"
  chmod 600 "$1"
  exec > >(tee -a "$1") 2>&1
}
