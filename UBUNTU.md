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

## [Optional]: LDAP Installation

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