init_logger() {
  touch "$1"
  chmod 600 "$1"
  LOG_FILE="$1"
}
