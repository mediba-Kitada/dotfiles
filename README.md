dotfiles
====

## Install

### Mac

#### google日本語入力

https://tools.google.com/dlpage/japaneseinput/eula.html?platform=mac&hl=ja

#### homebrew

```bash
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew tap b4b4r07/brionac
$ brew install brionac
```

#### shifit

http://shift-it.en.softonic.com/mac

#### dotfiles

```bash
$ cd ~/
$ git clone git@github.com:mediba-Kitada/dotfiles.git
$ cd ~/dotfiles
$ ./install.sh
```

#### zsh

```bash
$ source ~/.zshrc
```

#### vim

```zsh
$ brew uninstall vim
$ brew reinstall vim --with-lua
```

#### Ruby

```bash
# リファレンスのダウンロード
$ rbenv exec bundle exec bitclust setup
```

