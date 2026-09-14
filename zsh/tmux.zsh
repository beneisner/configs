# Turn off every mouse/focus reporting mode the terminal might have been left in.
#
# tmux (and vim, htop, ...) enable mouse tracking by writing DECSET sequences to
# the terminal, and turn them back off on exit. If an ssh session dies without a
# clean exit -- network drop, laptop sleep, server reboot -- the remote side never
# gets to send the "off" sequences, so the local terminal keeps reporting every
# mouse move as if it were typed input ("35;120;70M35;119;69M...").
fixterm() {
  # 9: X10   1000: button press/release   1001: hilite   1002: button-drag   1003: any-motion
  printf '\033[?9l\033[?1000l\033[?1001l\033[?1002l\033[?1003l'
  # 1004: focus reporting   1005/1006/1015: extended coordinate encodings
  printf '\033[?1004l\033[?1005l\033[?1006l\033[?1015l'
}

# Rename the tmux window to the ssh target (e.g. "ssh:index-pc-1") so tabs
# show which host is which. Restores automatic-rename when ssh exits, and
# always cleans up mouse mode in case the connection died uncleanly.
ssh() {
  local host="" skip=0 arg ret

  if [[ -n $TMUX ]]; then
    # Find the destination: first non-option arg, skipping values of options
    # that take a separate argument (-p 2222, -i key, -o opt, ...).
    for arg in "$@"; do
      if (( skip )); then skip=0; continue; fi
      case $arg in
        -[bcDEeFIiJLlmOopQRSWw]) skip=1 ;;
        -*) ;;
        *) host=${arg#*@}; break ;;
      esac
    done
    [[ -n $host ]] && tmux rename-window "ssh:${host}"
  fi

  command ssh "$@"
  ret=$?

  fixterm
  [[ -n $host ]] && tmux set-window-option automatic-rename on >/dev/null 2>&1
  return $ret
}
