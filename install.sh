#!/bin/sh

git submodule update --init --recursive

RUBY_VERSION=2.5.3
RSense_CONFIG='/usr/local/Cellar/rsense/0.3/libexec/etc/config.rb'
PYTHON_VERSION=3.7.2
NODE_VERSION='v10.15.1'

for i in `ls -a`
do
  rm ~/$i
  [ $i = "." ] && continue
  [ $i = ".." ] && continue
  [ $i = ".git" ] && continue
  [ $i = "README.md" ] && continue
  [ $i = "install.sh" ] && continue
  [ $i = "tmux-pbcopy" ] && continue
  ln -s ~/dotfiles/$i ~/
done

# vim初期設定
cp -R ./.vim ~/

# antigen
[ ! -d $HOME/.zsh/antigen ] && mkdir -p $HOME/.zsh && cd $HOME/.zsh && git clone git@github.com:zsh-users/antigen.git

# hub
mkdir -p $HOME/.zsh/completions
[ ! -d $HOME/repos/hub ] && mkdir -p $HOME/repos && cd $HOME/repos && git clone git@github.com:github/hub.git
[ ! -f $HOME/.zsh/completions/_hub ] && cp $HOME/repos/hub/etc/hub.zsh_completion $HOME/.zsh/completions/_hub

# setup zsh
source ~/.zshrc

# anyenv
git clone https://github.com/riywo/anyenv ./.anyenv
mkdir -p ./.anyenv/plugins
git clone https://github.com/znz/anyenv-update.git ./.anyenv/plugins/anyenv-update

# ruby
which anyenv && anyenv install rbenv
which anyenv exec rbenv && anyenv exec rbenv install $RUBY_VERSION && an exec rbenv global $RUBY_VERSION
[ -f $RSense_CONFIG ] && ruby $RSense_CONFIG > ~/.rsense

## bundler
which rbenv && rbenv exec gem install bundler

# python
# see https://medium.com/@digitalnauts/pyenv-install-error-mac-dcbd28fdc9db

# golang
[ ! -d $HOME/go ] && mkdir -p $HOME/go
[ -d $GOPATH ] && git config --global ghq.root $GOPATH/src

# node.js
mkdir $HOME/.nvm
nvm install $NODE_VERSION --lts
nvm version $NODE_VERSION
