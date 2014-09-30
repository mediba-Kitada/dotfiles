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

# Neobundleの導入
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

# php-cs-fixerの導入
sudo wget http://get.sensiolabs.org/php-cs-fixer.phar -O /usr/local/bin/php-cs-fixer
sudo chmod a+x /usr/local/bin/php-cs-fixer
