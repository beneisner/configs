# Ruby

## [Rbenv](https://github.com/rbenv/rbenv) - the ruby environment like Pyenv

```
# Install rbenv.
brew install rbenv

# Append the following to .zshrc.local
eval "$(rbenv init -)"

# Verify installation.
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
```

## Install a ruby.

```
# Find available versions.
rbenv install -l

# Install the version you want.
rbenv install <version>
```

# Jekyll

You're probably here so that you can use Jekyll locally. It's dumb I know. Otherwise why would you use Ruby...

```
# Install things.
gem install jekyll bundler

# Install the bundler jekyll.
bundle add jekyll

# Run Jekyll.
cd <website directory>
bundle exec jekyll serve
```
