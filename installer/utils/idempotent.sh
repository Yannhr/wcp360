install_if_missing() {
  dpkg -l | grep -q "$1" || apt install -y "$1"
}

service_running() {
  systemctl is-active --quiet "$1"
}
