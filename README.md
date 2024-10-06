# configs
My personal config files, for use when setting up a new computer.

# Table of Contents
[Installation](#installation)  
[macOS setup](#macos-specific-details)  
[Ubuntu setup](#ubuntu-specific-details)  


# Installation

First, install a nerd font:

https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#meslo-nerd-font-patched-for-powerlevel10k

Second, the entire repository should be set up using:

```
mkdir ~/code && cd ~/code
git clone git@github.com:beneisner/configs.git
cd configs
./setup.sh
```

# SSH Keys.

Adding SSH keys means we don't have to enter our username/password every time. macOS does a good job of storing passphrases in the keychain.

1. [Check for existing SSH Key.](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/checking-for-existing-ssh-keys)
2. If none exists, [Generate a new SSH Key.](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
3. [Add SSH Key to the agent.](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent)
4. [Add the SSH key to your Github account.](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

# macOS-specifc details

## XCode

```
sudo xcodebuild -license accept
```

## Preferences

Preferences that can be found in System Preferences.

* System Preferences > Keyboard > Modifier Keys > Caps Lock Key -> Control
* System Preferences > Keyboard > Key Repeat -> Fast
* System Preferences > Keyboard > Delay until Repeat -> Short
* Enable System Preferences > Trackpad > Point & Click > Tap to Click

## Other Apps

* Chrome
* Spotify
* Google Drive
* Slack
* Fantastical
* Mimestream
* Notion
* VSCode
* 1password
* Signal
* Whatsapp
* Messenger

# Ubuntu-specific details

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

## Other Apps

* Chrome
* Spotify
* Slack
* Notion
* VSCode
* 1password
* Signal
* Whatsapp
* Caprine