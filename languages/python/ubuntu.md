# Pyenv

It's the bees knees.

We use the [pyenv installer](https://github.com/pyenv/pyenv-installer).

```
curl https://pyenv.run | bash
```

Add the following to your `.zshrc.local`:

Note: this may change version to version.

```
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

# Poetry

Poetry is also exceptional.

```
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python - --no-modify-path
```

Add the following to your `.zshrc.local`

```
export PATH=$HOME/.poetry/bin:$PATH
```

Add autocompletion plugins:

```
mkdir $ZSH_CUSTOM/plugins/poetry
poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry
```
