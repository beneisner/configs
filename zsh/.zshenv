# Set XDG_CONFIG_HOME to ~/.config. This is where all the configuration files will be stored.
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_CACHE_HOME=${HOME}/.cache

# Set the ZSH root directory.
export ZDOTDIR=${XDG_CONFIG_HOME}/zsh

# Other ZSH settings.
export EDITOR='vim'