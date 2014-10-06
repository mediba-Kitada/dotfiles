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
[ -d ~/.vim/bundle ] || mkdir -p ~/.vim/bundle
[ -d ~/.vim/tags/ ] || mkdir -p ~/.vim/tags/
[ -d ~/.vim/dict/ ] || mkdir -p ~/.vim/dict/
[ -d ~/.vim/bundle/neobundle.vim ] || git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

# php-cs-fixerの導入
[ -f /usr/local/bin/php-cs-fixer ] || sudo wget http://get.sensiolabs.org/php-cs-fixer.phar -O /usr/local/bin/php-cs-fixer
sudo chmod a+x /usr/local/bin/php-cs-fixer

# PHP辞書ファイル
[ -f ~/.vim/dict/php.dict ] || php -r '$f=get_defined_functions();echo join("\n",$f["internal"]);'|sort > ~/.vim/dict/php.dict
