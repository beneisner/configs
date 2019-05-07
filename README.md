# configs
My personal config files, for use when setting up a new computer.

# macOS setup

## macOS Preferences

Preferences that can be found in System Preferences.

* System Preferences > Keyboard > Modifier Keys > Caps Lock Key -> Control
* System Preferences > Keyboard > Key Repeat -> Fast
* System Preferences > Keyboard > Delay until Repeat -> Short
* Enable System Preferences > Trackpad > Point & Click > Tap to Click

## Spectacle

Install and configure Spectacle, a great window manager for macOS.

* Download [Spectacle](https://www.spectacleapp.com/)
* Start Spectacle
    * Allow it Accessibility permissions.
* Enable Spectacle > Preferences > Launch Spectacle at login

## Brew

Brew is the de-facto standard package manager for macOS. We'll install some basics, but we don't really want to use brew for day-to-day development, because it contaminates the machine. 

*Rule of thumb: only `brew install` things that are environment-independent, and are used across coding environments*

```
# Install git, overriding the system default so we can get frequent updates.
brew install git

# Install python3, which is used by various code editors and tools.
# This version should ***NOT*** be used for actually running code we wrote;
# we leave that to the isolated dev environments.
brew install python3

# Install cmake. It's useful sometimes.
brew install cmake

# Autotools :(
brew install automake

# Libtool
brew install libtool
```

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

`brew cask install iterm2`

Allow it Accessibility permissions.

### iTerm2 Color Schemes

Download some slick iTerm2 color schemes.

```
cd ~/code
git clone https://github.com/mbadolato/iTerm2-Color-Schemes
```

## tmux

tmux is the best terminal multiplexer out there.
```
# Install tmux.
brew install tmux

# Symlink the config in this directory.
ln -s ~/code/configs/.tmux.conf ~/.tmux.conf
```

## Powerline

Powerline is going to be useful for tmux and for vim, so let's install it now.

```
# Install the package.
pip3 install powerline-status
```

## zsh

zsh is a shell built on top of bash that has some nice features.
```
# Install zsh.
brew install zsh

# Symlink the zsh config.
ln -s ~/code/configs/.zshrc ~/.zshrc
```

### Oh My ZSH

Oh My ZSH is a package manager for zsh. It's got a lot of stars on github. We do a manual installation instead of the normal one so that our zsh file isn't overwritten.

```
# Download and Oh My zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Change the default shell to zsh.
chsh -s /bin/zsh
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

#### Bazel completion
```
git clone https://github.com/jackwish/bazel ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/bazel
```

### Initialize completion/

```
compinit
```

## Set iTerm2 to point to our custom preferences.
* iTerm2 > Preferences > General > Load preferences from a custom folder or URL -> Enable, ~/code/configs/iterm2
* iTerm2 > Preferences > General > Save current settings to folder when iTerm2 quits -> Enable

## XCode

```
sudo xcodebuild -license accept
```


## Install Bazel

```
# Install from Homebrew.
brew tap bazelbuild/tap
brew install bazelbuild/tap/bazel
```

Install Buildifier.
```
https://github.com/bazelbuild/buildtools/blob/master/buildifier/README.md
```

## Backup and Sync
https://www.google.com/drive/download/backup-and-sync/

## Boxy Suite (Gmail and Calendar)
https://www.boxysuite.com/

## Mendeley
https://www.mendeley.com/download-desktop/

## SSHFS + Fuse

For mounting remote filesystems.
* brew cask install osxfuse
* brew install sshfs
* https://osxfuse.github.io/
