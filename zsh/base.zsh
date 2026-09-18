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

# So that Shift+Enter is fine (needed for claude code and other things in tmux
bindkey '^[[13;2u' accept-line


# Compinit configuration.
zstyle ':plugin:ez-compinit' 'compstyle' 'prez'

# Load antidote.
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
# Bundle list is shared config; the generated static file points into the machine-local
# plugin cache, so it must be machine-local too (shared home on the NAS).
antidote load ${ZDOTDIR:-~}/.zsh_plugins.txt ${XDG_CACHE_HOME:-$HOME/.cache}/antidote/.zsh_plugins.zsh

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

