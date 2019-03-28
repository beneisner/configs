# configs
My personal config files, for use when setting up a new computer.

# macOS setup

- macOS preferences
  - map caps-lock to control

- Spectacle
  - open on login
  
- Homebrew
  - brew install git
  - brew install python3
  
- Github
  - Add SSH key to account ([Instructions](https://help.github.com/en/articles/connecting-to-github-with-ssh))
    - `ssh-keygen -t rsa -b 4096 -C "ben.a.eisner@gmail.com"`
      - Default location is fine.
      - Save a passphrase in 1Password.
    - Add to Github account.
  - Add SSH key to keychain ([Instructions](https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent))
    - Create/modify ~/.ssh/config using provided Hosts.
    - `ssh-add -K ~/.ssh/id_rsa`, and enter passphrase. This stores the passphrase in the keychain.

- Bootstrap coding environment
  - `mkdir ~/code`
  - `git clone 
  
- Visual Studio Code [Download](https://code.visualstudio.com/download)
  - Extensions:
    - Python: [ms-python.python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
  - Configs:
- iTerm2
