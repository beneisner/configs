# Ubuntu Setup Instructions

# OS Configuration

## GNOME Tweaks.

To enable workspaces across dual monitors:

```
sudo apt-get install gnome-tweaks
gnome-tweaks
```

Enable Workspaces -> Workspaces Span display

Reference: https://askubuntu.com/questions/1059479/dual-monitor-workspaces-in-ubuntu-18-04


## Enable SSH.
```
sudo apt-get install openssh-server
```

# Dev Environment.

## Set up SSH keys for Github

Adding SSH keys means we don't have to enter our username/password every time. macOS does a good job of storing passphrases in the keychain.

1) Add SSH key to account ([Instructions](https://help.github.com/en/articles/connecting-to-github-with-ssh))
    * `ssh-keygen -t rsa -b 4096 -C "ben.a.eisner@gmail.com"`
        * Default location is fine.
        * Save a passphrase in 1Password.
    * Add to Github account.
2) Add SSH key to keychain ([Instructions](https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent))
    * Create/modify ~/.ssh/config using provided Hosts.
    * `ssh-add -K ~/.ssh/id_rsa`, and enter passphrase. This stores the passphrase in the keychain.


## Bootstrap Configs

1) All code should live in `~/code`, especially if this is a personal computer, so that we don't contaminate personal data.
```
mkdir ~/code && cd ~/code
```

2) Clone this repository into code, so we can access all our configuration files.
```
git clone git@github.com:beneisner/configs.git
```

## tmux


## tmux

tmux is the best terminal multiplexer out there.
```
# Install tmux.
sudo apt-get install tmux

# Symlink the config in this directory.
ln -s ~/code/configs/.tmux.conf ~/.tmux.conf

```

### tmux plugin manager
Use the TMUX Plugin Manager [https://github.com/tmux-plugins/tpm](link).

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Powerline

Powerline is going to be useful for tmux and for vim, so let's install it now.

```
# Install the package.
pip3 install --user powerline-status
```

## zsh

zsh is a shell built on top of bash that has some nice features.
```
# Install zsh.
brew install zsh

# Symlink the zsh config.
ln -s ~/code/configs/.zshrc ~/.zshrc
```

#### Oh My ZSH Fonts - Powerline
Neat font [link](https://github.com/powerline/fonts).
```
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
```

#### Syntax highlighting
Syntax highlighting for zsh [link](https://github.com/zsh-users/zsh-syntax-highlighting).
```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

#### Install zsh-autosuggestions
Autosuggestions that can be completed with the right arrow key.
```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```


# Applications

## Downloadable

* Google Chrome

## Snaps

Install the following from the Ubuntu App Store.

* Spotify
* Slack
* Visual Studio Code
* PyCharm

# Dev environment.

## tmux
```
# Symlink the config in this directory.
ln -s ~/code/configs/.tmux.conf ~/.tmux.conf
```
