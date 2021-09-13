# Probably installing to use buildifier, bazelisk


## GVM [https://github.com/moovweb/gvm]

```
# Requirements
sudo apt-get install curl git mercurial make binutils bison gcc build-essential

# Zsh install
zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

# Install a go version, and use it everywhere
gvm install go1.17
gvm use go1.17
```

## Buildifier
```
go install github.com/bazelbuild/buildtools/buildifier
```

## Bazelisk
```
go install github.com/bazelbuild/bazelisk@v1.10.1
```
