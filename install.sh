#!/bin/sh

git submodule init
git submodule update

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
