init_state() {
  mkdir -p /var/lib/wcp360
  echo '{"status":"started"}' > "$1"
}
