# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Use TMUX on every start, unless we're SSH-ing in.
if [[ -n $SSH_CONNECTION ]]; then
  ZSH_TMUX_AUTOSTART=false
# Use TMUX on every start, except when using the vscode terminal.
elif [ "$TERM_PROGRAM" = "vscode" ] || [ "$TERM_PROGRAM" = "zed" ]; then 
  ZSH_TMUX_AUTOSTART=false
elif [[ ! -t 0 ]]; then
  # Not running in a terminal
  ZSH_TMUX_AUTOSTART=false
else
  ZSH_TMUX_AUTOSTART=true
fi


# Compinit configuration.
zstyle ':plugin:ez-compinit' 'compstyle' 'prez'

# Load antidote.
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
