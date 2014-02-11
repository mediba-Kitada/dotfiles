#!/bin/sh

[[ -e ~/.dotfiles ]] || git clone git@github.com:mediba-Kitada/dotfiles.git .dotfiles
pushd ~/.dotfiles

git submodule init
git submodule update

for i in `ls -a`
do
  [ $i = "." ] && continue
  [ $i = ".." ] && continue
  [ $i = ".git" ] && continue
  [ $i = "README.md" ] && continue
  [ $i = "install.sh" ] && continue
  ln -s ~/.dotfiles/$i ~/
done
