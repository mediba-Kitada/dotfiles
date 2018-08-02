#!/bin/sh

git submodule update --init --recursive

RUBY_VERSION=2.2.3
RSense_CONFIG='/usr/local/Cellar/rsense/0.3/libexec/etc/config.rb'
PAKER_VERSION=0.8.6
PYTHON_VERSION=3.6.1

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

# Neobundleの導入
[ ! -d ~/.vim/bundle ] && mkdir -p ~/.vim/bundle
[ ! -d ~/.vim/tags/ ] && mkdir -p ~/.vim/tags/
[ ! -d ~/.vim/dict/ ] && mkdir -p ~/.vim/dict/
[ ! -d ~/.vim/vim-ref/cache ] && mkdir -p ~/.vim/vim-ref/cache
[ ! -d ~/.vim/bundle/neobundle.vim ] && git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

# php-cs-fixerの導入
[ ! -f /usr/local/bin/php-cs-fixer ] || sudo wget http://get.sensiolabs.org/php-cs-fixer.phar -O /usr/local/bin/php-cs-fixer
sudo chmod a+x /usr/local/bin/php-cs-fixer

# PHP辞書ファイル
[ ! -f ~/.vim/dict/php.dict ] && php -r '$f=get_defined_functions();echo join("\n",$f["internal"]);'|sort > ~/.vim/dict/php.dict

# PHPマニュアル
[ ! -d ~/.vim/vim-ref/php-chunked-xhtml ] && cd ~/.vim/vim-ref && wget http://jp2.php.net/distributions/manual/php_manual_ja.tar.gz && tar -zxvf php_manual_ja.tar.gz -C ~/.vim/vim-ref

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
which anyenv && anyenv install pyenv && source ~/.zshrc
# which pyenv && pyenv install $PYTHON_VERSION && pyenv global $PYTHON_VERSION
which pip && pip install --user powerline-status

# packer
[ ! -d $HOME/packer ] && mkdir -p $HOME/packer && cd $HOME/Downloads && wget -O https://releases.hashicorp.com/packer/${PAKER_VERSION}/packer_${PAKER_VERSION}_darwin_amd64.zip && unzip packer_${PAKER_VERSION}_darwin_amd64.zip -d $HOME/packer

# golang
[ ! -d $HOME/go ] && mkdir -p $HOME/go
[ -d $GOPATH ] && git config --global ghq.root $GOPATH/src
