# Rename the tmux window to the ssh target (e.g. "ssh:index-pc-1") so tabs
# show which host is which. Restores automatic-rename when ssh exits.
ssh() {
  if [[ -z $TMUX ]]; then
    command ssh "$@"
    return
  fi

  # Find the destination: first non-option arg, skipping values of options
  # that take a separate argument (-p 2222, -i key, -o opt, ...).
  local host="" skip=0 arg
  for arg in "$@"; do
    if (( skip )); then skip=0; continue; fi
    case $arg in
      -[bcDEeFIiJLlmOopQRSWw]) skip=1 ;;
      -*) ;;
      *) host=${arg#*@}; break ;;
    esac
  done

  if [[ -z $host ]]; then
    command ssh "$@"
    return
  fi

  tmux rename-window "ssh:${host}"
  command ssh "$@"
  local ret=$?
  tmux set-window-option automatic-rename on >/dev/null 2>&1
  return $ret
}
