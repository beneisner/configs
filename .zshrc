# List the Oh-My-Zsh plugins up front, before we import ZSH config.
plugins=(
  git
  tmux
  zsh-syntax-highlighting
  zsh-autosuggestions
  colored-man-pages
  bazel
  poetry
)

CONFIG_DIR=${HOME}/code/configs

source ${CONFIG_DIR}/zsh/zshrc_base
source ${CONFIG_DIR}/zsh/fast_paste_rc
source ${CONFIG_DIR}/zsh/zsh_tmux

# source ${CONFIG_DIR}/languages/python/python.zshrc