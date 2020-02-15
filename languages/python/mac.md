# Configure a Python environment on mac OS.

TODO: Decide if this should be standard.

1. Install Python at the system level.

```
brew install python
```

2. The system Python is trash. Use pyenv to manage your python versions for real.

```
# Install pyenv.
brew install pyenv

# Install the latest version of Python, or whatever Python you want.
pyenv install 3.8.1

# Make sure that it goes in the local zshrc! Otherwise you can't do anything.
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc.local
```

3. Dependency management in Python is trash. Use poetry, because it attempts to mask the smell.

```
# Install poetry.
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python

# Put poetry in the path.
echo 'export PATH=$HOME/.poetry/bin:$PATH' >> ~/.zshrc.local

# Source.
source ~/.zshrc

# Install the zsh completions.
mkdir $ZSH/plugins/poetry
poetry completions zsh > $ZSH/plugins/poetry/_poetry
```
