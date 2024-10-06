# Check if we're on macOS or linux.
if [ "$(uname)" = "Darwin" ]; then
    # Load Homebrew's shell environment.
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
