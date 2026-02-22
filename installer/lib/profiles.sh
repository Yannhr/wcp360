get_profile_steps() {
  case $1 in
    minimal)
      echo "01-system.sh 02-security.sh 03-web.sh 06-core.sh 09-finalize.sh"
      ;;
    full)
      echo "01-system.sh 02-security.sh 03-web.sh 04-database.sh 05-mail.sh 06-core.sh 07-monitoring.sh 08-backup.sh 09-finalize.sh"
      ;;
    *)
      echo "Invalid profile"; exit 1;
      ;;
  esac
}
