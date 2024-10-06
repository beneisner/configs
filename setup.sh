#!/bin/bash
# Install the full environment for the user.

set -e

# Define a function which asks the user whether or not to setup a particular thing, requiring them to press enter.
function ask_user() {
    read -p "$1 (y/n) " -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}

# Get the actual parent dir of this file (setup.sh), no matter where it is called from.
# Use realpath
BEN_CONFIG_DIR=$(dirname $(realpath $0))


echo "###############################################"
echo "Setting up Ben's environment..."
echo "Platform: $(uname)"
echo "BEN_CONFIG_DIR: $BEN_CONFIG_DIR"
echo "###############################################"

#######################################################
# Package managers
#######################################################

if [ "$(uname)" == "Darwin" ]; then
    # Check if Homebrew is installed (not using 'brew' because it is not in the PATH yet).
    if ! command -v /opt/homebrew/bin/brew &> /dev/null; then
        echo "Homebrew is not installed. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew is already installed, skipping..."
    fi
elif [ "$(uname)" == "Linux" ]; then
    # Do nothing.
    echo "Linux detected, skipping Homebrew installation..."
fi

#######################################################
# OS-specific apps.
#######################################################
# Mac Apps.


if [ "$(uname)" == "Darwin" ]; then
    if ask_user "Do you want to install Mac software?"; then
        # Install Mac apps.
        echo "Installing Mac apps..."
        brew install git htop
        brew install --cask rectangle
    fi
fi

#######################################################
# Wezterm
#######################################################

# Install wezterm - use Homebrew on Mac, apt-get on Linux.
if ! command -v wezterm &> /dev/null; then
    if [ "$(uname)" == "Darwin" ]; then
        echo "wezterm is not installed. Installing wezterm..."
        brew install --cask wezterm
    elif [ "$(uname)" == "Linux" ]; then
        # See https://wezfurlong.org/wezterm/install/linux.html#__tabbed_1_3

        curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
        echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
        sudo apt-get update
        sudo apt-get install wezterm
    fi
else
    echo "wezterm is already installed, skipping..."
fi


#######################################################
# Zsh.
#######################################################

# Install zsh - use Homebrew on Mac, apt-get on Linux.
if [ "$(uname)" == "Darwin" ]; then
    if ! command -v zsh &> /dev/null; then
        echo "zsh is not installed. Installing zsh..."
        brew install zsh
    else
        echo "zsh is already installed, skipping..."
    fi
elif [ "$(uname)" == "Linux" ]; then
    if ! command -v zsh &> /dev/null; then
        echo "zsh is not installed. Installing zsh..."
        sudo apt-get install zsh
    else
        echo "zsh is already installed, skipping..."
    fi
fi

# Check if zsh is the default shell.
if [ "$SHELL" != "$(which zsh)" ]; then
    # Ask the user if they want to set zsh as the default shell.
    if ask_user "Do you want to set zsh as the default shell?"; then
        sudo chsh -s $(which zsh)
    fi
else
    echo "zsh is the default shell, skipping..."
fi

# Check if ~/.zshenv exists, or if it does exist then ask the user if they want to overwrite it (do this in a single line).
# Unfortunately, we can't use the $ZDOTDIR variable here because it is not defined yet.
echo "Setting up ~/.zshenv..."
if [ -f ~/.zshenv ] && ! ask_user "~/.zshenv exists. Do you want to overwrite ~/.zshenv?"; then
    echo "Skipping writing ~/.zshenv..."
else
    # Make a backup of the existing ~/.zshenv file, if it exists.
    if [ -f ~/.zshenv ]; then
        echo "Backing up ~/.zshenv to ~/.zshenv.bak"
        cp ~/.zshenv ~/.zshenv.bak
    fi

    echo "Copying $BEN_CONFIG_DIR/zsh/.zshenv to ~/.zshenv"
    cp $BEN_CONFIG_DIR/zsh/.zshenv ~/.zshenv

    # Load the new ~/.zshenv file.
    source ~/.zshenv
fi

# Make the ZSH root directory.
if [ ! -d $ZDOTDIR ]; then
    echo "Creating $ZDOTDIR..."
    mkdir -p $ZDOTDIR
else
    echo "$ZDOTDIR already exists, skipping..."
fi

# Copy .zprofile.
echo "Copying $BEN_CONFIG_DIR/zsh/.zprofile to $ZDOTDIR/.zprofile..."
if [ -f $ZDOTDIR/.zprofile ] && ! ask_user "$ZDOTDIR/.zprofile exists. Do you want to overwrite $ZDOTDIR/.zprofile?"; then
    echo "Skipping linking $ZDOTDIR/.zprofile..."
else
    if [ -f $ZDOTDIR/.zprofile ]; then
        # If it's a symlink, then remove it.
        if [ -L $ZDOTDIR/.zprofile ]; then
            echo "Removing existing symlink $ZDOTDIR/.zprofile..."
            rm $ZDOTDIR/.zprofile
        else
            echo "Backing up $ZDOTDIR/.zprofile to $ZDOTDIR/.zprofile.bak"
            cp $ZDOTDIR/.zprofile $ZDOTDIR/.zprofile.bak
        fi
    fi
    cp $BEN_CONFIG_DIR/zsh/.zprofile $ZDOTDIR/.zprofile
fi

# Install antidote for zsh.
if [ ! -d $ZDOTDIR/.antidote ]; then
    echo "Installing antidote for zsh..."
    git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
else
    echo "antidote is already installed, skipping..."
fi

# Link (not copy) antidote plugin file .zsh_plugins.txt
echo "Linking $BEN_CONFIG_DIR/zsh/.zsh_plugins.txt to $ZDOTDIR/.zsh_plugins.txt..."
if [ -f $ZDOTDIR/.zsh_plugins.txt ] && ! ask_user "$ZDOTDIR/.zsh_plugins.txt exists. Do you want to overwrite $ZDOTDIR/.zsh_plugins.txt?"; then
    echo "Skipping linking $ZDOTDIR/.zsh_plugins.txt..."
else
    if [ -f $ZDOTDIR/.zsh_plugins.txt ]; then
        # If it's a symlink, then remove it.
        if [ -L $ZDOTDIR/.zsh_plugins.txt ]; then
            echo "Removing existing symlink $ZDOTDIR/.zsh_plugins.txt..."
            rm $ZDOTDIR/.zsh_plugins.txt
        else
            echo "Backing up $ZDOTDIR/.zsh_plugins.txt to $ZDOTDIR/.zsh_plugins.txt.bak"
            cp $ZDOTDIR/.zsh_plugins.txt $ZDOTDIR/.zsh_plugins.txt.bak
        fi
    fi
    ln -s $BEN_CONFIG_DIR/zsh/.zsh_plugins.txt $ZDOTDIR/.zsh_plugins.txt
fi


# Check if $ZDOTDIR/.zshrc exists, or if it does exist then ask the user if they want to overwrite it (do this in a single line).
echo "Setting up $ZDOTDIR/.zshrc..."
if [ -f $ZDOTDIR/.zshrc ] && ! ask_user "$ZDOTDIR/.zshrc exists. Do you want to overwrite $ZDOTDIR/.zshrc?"; then
    echo "Skipping writing $ZDOTDIR/.zshrc..."
else
    if [ -f $ZDOTDIR/.zshrc ]; then
        echo "Backing up $ZDOTDIR/.zshrc to $ZDOTDIR/.zshrc.bak"
        cp $ZDOTDIR/.zshrc $ZDOTDIR/.zshrc.bak
    fi
    echo "Copying $BEN_CONFIG_DIR/zsh/.zshrc to $ZDOTDIR/.zshrc"
    cp $BEN_CONFIG_DIR/zsh/.zshrc $ZDOTDIR/.zshrc
fi


# Link powerlevel10k config file.
echo "Linking $BEN_CONFIG_DIR/zsh/.p10k.zsh to $ZDOTDIR/.p10k.zsh..."
if [ -f $ZDOTDIR/.p10k.zsh ] && ! ask_user "$ZDOTDIR/.p10k.zsh exists. Do you want to overwrite $ZDOTDIR/.p10k.zsh?"; then
    echo "Skipping linking $ZDOTDIR/.p10k.zsh..."
else
    if [ -f $ZDOTDIR/.p10k.zsh ]; then
        # If it's a symlink, then remove it.
        if [ -L $ZDOTDIR/.p10k.zsh ]; then
            echo "Removing existing symlink $ZDOTDIR/.p10k.zsh..."
            rm $ZDOTDIR/.p10k.zsh
        else
            echo "Backing up $ZDOTDIR/.p10k.zsh to $ZDOTDIR/.p10k.zsh.bak"
            cp $ZDOTDIR/.p10k.zsh $ZDOTDIR/.p10k.zsh.bak
        fi
    fi
    ln -s $BEN_CONFIG_DIR/zsh/.p10k.zsh $ZDOTDIR/.p10k.zsh
fi

#######################################################
# Tmux
#######################################################
# Install tmux - use Homebrew on Mac, apt-get on Linux.
if ! command -v tmux &> /dev/null; then
    if [ "$(uname)" == "Darwin" ]; then
        echo "tmux is not installed. Installing tmux..."
        brew install tmux
    elif [ "$(uname)" == "Linux" ]; then
        echo "tmux is not installed. Installing tmux..."
        sudo apt-get install tmux
    fi
else
    echo "tmux is already installed, skipping..."
fi

# Set things up under XDG_CONFIG_HOME.
if [ ! -d $XDG_CONFIG_HOME/tmux ]; then
    echo "Creating $XDG_CONFIG_HOME/tmux..."
    mkdir -p $XDG_CONFIG_HOME/tmux
else
    echo "$XDG_CONFIG_HOME/tmux already exists, skipping..."
fi

# Link the tmux config file.
echo "Linking $BEN_CONFIG_DIR/tmux/.tmux.conf to $XDG_CONFIG_HOME/tmux/tmux.conf..."
if [ -f $XDG_CONFIG_HOME/tmux/tmux.conf ] && ! ask_user "$XDG_CONFIG_HOME/tmux/tmux.conf exists. Do you want to overwrite $XDG_CONFIG_HOME/tmux/tmux.conf?"; then
    echo "Skipping linking $XDG_CONFIG_HOME/tmux/.tmux.conf..."
else
    if [ -f $XDG_CONFIG_HOME/tmux/tmux.conf ]; then
        # If it's a symlink, then remove it.
        if [ -L $XDG_CONFIG_HOME/tmux/tmux.conf ]; then
            echo "Removing existing symlink $XDG_CONFIG_HOME/tmux/tmux.conf..."
            rm $XDG_CONFIG_HOME/tmux/tmux.conf
        else
            echo "Backing up $XDG_CONFIG_HOME/tmux/tmux.conf to $XDG_CONFIG_HOME/tmux/tmux.conf.bak"
            cp $XDG_CONFIG_HOME/tmux/tmux.conf $XDG_CONFIG_HOME/tmux/tmux.conf.bak
        fi
    fi
    ln -s $BEN_CONFIG_DIR/.tmux.conf $XDG_CONFIG_HOME/tmux/tmux.conf
fi

# Install TPM
if [ ! -d $XDG_CONFIG_HOME/tmux/plugins/tpm ]; then
    echo "Installing TPM..."
    mkdir -p $XDG_CONFIG_HOME/tmux/plugins
    git clone https://github.com/tmux-plugins/tpm $XDG_CONFIG_HOME/tmux/plugins/tpm
else
    echo "TPM is already installed, skipping..."
fi

# Link tmux-powerline config
echo "Linking $BEN_CONFIG_DIR/tmux-powerline/config.sh to $XDG_CONFIG_HOME/tmux-powerline/config.sh..."
mkdir -p $XDG_CONFIG_HOME/tmux-powerline
if [ -f $XDG_CONFIG_HOME/tmux-powerline/config.sh ] && ! ask_user "$XDG_CONFIG_HOME/tmux-powerline/config.sh exists. Do you want to overwrite $XDG_CONFIG_HOME/tmux-powerline/config.sh?"; then
    echo "Skipping linking $XDG_CONFIG_HOME/tmux-powerline/config.sh..."
else
    if [ -f $XDG_CONFIG_HOME/tmux-powerline/config.sh ]; then
        # If it's a symlink, then remove it.
        if [ -L $XDG_CONFIG_HOME/tmux-powerline/config.sh ]; then
            echo "Removing existing symlink $XDG_CONFIG_HOME/tmux-powerline/config.sh..."
            rm $XDG_CONFIG_HOME/tmux-powerline/config.sh
        else
            echo "Backing up $XDG_CONFIG_HOME/tmux-powerline/config.sh to $XDG_CONFIG_HOME/tmux-powerline/config.sh.bak"
            cp $XDG_CONFIG_HOME/tmux-powerline/config.sh $XDG_CONFIG_HOME/tmux-powerline/config.sh.bak
        fi
    fi
    ln -s $BEN_CONFIG_DIR/tmux-powerline/config.sh $XDG_CONFIG_HOME/tmux-powerline/config.sh
fi


#######################################################
# Python
#######################################################

function setup_python() {
    if ! command -v pyenv &> /dev/null; then
        echo "pyenv is not installed. Installing pyenv..."
        if [ "$(uname)" == "Darwin" ]; then
            brew install pyenv
        elif [ "$(uname)" == "Linux" ]; then
            curl https://pyenv.run | bash
        fi
    fi

    # Add the following line to .zshrc and .zprofile:
    # "source ${CONFIG_DIR}/languages/python/python.zsh"
    echo "Adding source line to $ZDOTDIR/.zshrc..."
    if ! grep -q "source ${BEN_CONFIG_DIR}/languages/python/python.zsh" $ZDOTDIR/.zshrc; then
        echo "\nsource ${BEN_CONFIG_DIR}/languages/python/python.zsh" >> $ZDOTDIR/.zshrc
    else
        echo "\nsource line already exists in $ZDOTDIR/.zshrc, skipping..."
    fi

    echo "Adding source line to $ZDOTDIR/.zprofile..."
    if ! grep -q "source ${BEN_CONFIG_DIR}/languages/python/python.zsh" $ZDOTDIR/.zprofile; then
        echo "\nsource ${BEN_CONFIG_DIR}/languages/python/python.zsh" >> $ZDOTDIR/.zprofile
    else
        echo "source line already exists in $ZDOTDIR/.zprofile, skipping..."
    fi

}

# First, ask if we want to even install python.
if ask_user "Do you want to setup Python (via pyenv)?"; then
    setup_python
fi

#######################################################
# Bazel
#######################################################

function install_bazel() {
    if ! command -v bazel &> /dev/null; then
        echo "bazel is not installed. Installing bazelisk..."
        if [ "$(uname)" == "Darwin" ]; then
            brew install bazelisk buildifier
        elif [ "$(uname)" == "Linux" ]; then
            echo "UNIMPLEMENTED: Install bazelisk & buildifier on Linux..."
        fi
    fi
}

echo "Done setting up Ben's environment. Restart your shell to see the changes."

