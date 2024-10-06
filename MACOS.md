# configs
My personal config files, for use when setting up a new computer.

# macOS setup


## Brew

Brew is the de-facto standard package manager for macOS. We'll install some basics, but we don't really want to use brew for day-to-day development, because it contaminates the machine. 

*Rule of thumb: only `brew install` things that are environment-independent, and are used across coding environments*

```
# Install git, overriding the system default so we can get frequent updates.
brew install git

brew install htop
```

## Rectangle

Install and configure [Rectangle](https://github.com/rxhanson/Rectangle), a great window manager for macOS.

* Run `brew install --cask rectangle`
* Start Rectangle
    * Allow it Accessibility permissions.
* Enable Rectangle > Preferences > Launch Spectacle at login


## Set up SSH keys for Github

Adding SSH keys means we don't have to enter our username/password every time. macOS does a good job of storing passphrases in the keychain.

1. [Check for existing SSH Key.](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/checking-for-existing-ssh-keys)
2. If none exists, [Generate a new SSH Key.](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
3. [Add SSH Key to the agent.](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent)
4. [Add the SSH key to your Github account.](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

## Bootstrap dev machine

1) All code should live in `~/code`, especially if this is a personal computer, so that we don't contaminate personal data.
```
mkdir ~/code && cd ~/code
```

2) Clone this repository into code, so we can access all our configuration files.
```
git clone git@github.com:beneisner/configs.git
```

## Visual Studio Code

Visual Studio Code has replaced Sublime Text 3 as the de-facto text editor, and has a litany of extensions that are super-useful for everyday coding.

1) [Download Visual Studio Code](https://code.visualstudio.com/download)

2) Install the following extensions:
    * Python ([ms-python.python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)): Python language extension.
    * Bazel ([vscode-bazel](https://marketplace.visualstudio.com/items?itemName=BazelBuild.vscode-bazel&ssr=false)): Bazel extension.
  
3) Set up our configuration files by symlinking them into the appropriate directories.

```
ln -s ~/code/configs/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
```

## iTerm2

iTerm2 is a great terminal replacement for macOS. I'm not sure why but everyone says it is and that's great.

`brew install --cask iterm2`

Allow it Accessibility permissions.

### iTerm2 Color Schemes

Download some slick iTerm2 color schemes.

```
cd ~/code
git clone https://github.com/mbadolato/iTerm2-Color-Schemes
```

Install them by following instructions [here](https://github.com/mbadolato/iTerm2-Color-Schemes?tab=readme-ov-file#installation-instructions).

Currently using Sakura.

## tmux

tmux is the best terminal multiplexer out there.
```
# Install tmux.
brew install tmux

# Symlink the config in this directory.
ln -s ~/code/configs/.tmux.conf ~/.tmux.conf

```
### tmux plugin manager
Use the TMUX Plugin Manager [https://github.com/tmux-plugins/tpm](link).

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

We have several plugins installed, including powerline.

#### Powerline themes.

```
ln -s ~/code/configs/tmux-powerline/config.sh ~/.config/tmux-powerline/config.sh
```

## zsh

zsh is a shell built on top of bash that has some nice features.
```
# Install zsh.
brew install zsh

# Symlink the zsh config.
ln -s ~/code/configs/.zshrc ~/.zshrc

# Add Homebrew ZSH to list of shells.
https://github.com/fish-shell/fish-shell/issues/989#issuecomment-139900718
```

### Oh My ZSH

Oh My ZSH is a package manager for zsh. It's got a lot of stars on github. We do a manual installation instead of the normal one so that our zsh file isn't overwritten.

```
# Download and Oh My zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Change the default shell to zsh.
chsh -s /opt/homebrew/bin/zsh
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

#### powerlevel10k theme

Pretty slick.

```git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k```

Manually install the fonts:
https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#meslo-nerd-font-patched-for-powerlevel10k

Edit the iterm2 profile appropriately.


#### Install the TPM Plugins.

In tmux:
```
Ctrl+A Shift+I
```

## XCode

```
sudo xcodebuild -license accept
```


## Install Bazel (managed by Bazelisk)

```
brew install bazelisk
```

Install Buildifier.
```
brew install buildifier
```

## Other Apps

* Spotify
* Google Drive
* Slack
* Fantastical
* Mimestream
