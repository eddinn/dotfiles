# ZSH and .zshrc

My .zshrc config file with [Oh-My-ZSH](https://github.com/robbyrussell/oh-my-zsh)

- **Global version:** [https://github.com/eddinn/zsh/blob/master/.zshrc](https://github.com/eddinn/zsh/blob/master/.zshrc)

---

## ZSH and Oh-My-Zsh installation

### Ubuntu

```bash
sudo apt install zsh powerline fonts-powerline zsh-syntax-highlighting git curl
echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
chsh -s $(which zsh) # Might need sudo
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

#### Fedora

```bash
sudo dnf install zsh powerline powerline-fonts zsh-syntax-highlighting git curl
echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
chsh -s $(which zsh) # Might need sudo
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

---

### Theme and plugins

```bash
vim ~/.zshrc
```

#### Theme

ZSH_THEME="agnoster"

#### Plugins

```.zshrc
plugins=(
  git
  bundler
  dotenv
  osx
  rake
  rbenv
  ruby
)
```

#### My .zshrc plugin list

- git
- dotenv
- rake
- ruby
- ansible
- autoenv
- autopep8
- docker
- docker-compose
- docker-machine
- django
- git-prompt
- gnu-utils
- man
- nmap
- npm
- pip
- pipenv
- pyenv
- pylint
- python
- rsync
- sudo
- systemd
- ubuntu
- virtualenv
- vscode
