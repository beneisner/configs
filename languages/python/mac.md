# Configure a Python environment on mac OS.

1. Use pyenv to manage your python versions for real.

```
# Install pyenv and pyenv-virtualenv
brew install pyenv
brew install pyenv-virtualenv

# Install the latest version of Python, or whatever Python you want.
pyenv install <version>
```

Then add the following to your .zshrc.
```
source ${CONFIG_DIR}/languages/python/python.zshrc
```
