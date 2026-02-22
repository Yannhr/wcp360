progress_bar() {
  percent=$(( $1 * 100 / $2 ))
  filled=$(( percent / 5 ))
  empty=$(( 20 - filled ))

  printf "["
  printf "%0.s#" $(seq 1 $filled)
  printf "%0.s-" $(seq 1 $empty)
  printf "] %d%%\n" "$percent"
}
