#!/bin/sh

git submodule init
git submodule update

RUBY_VERSION=2.2.3
PAKER_VERSION=0.8.6

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

# zshコマンド補完
mkdir -p $HOME/.zsh/completions

# Neobundleの導入
[ ! -d ~/.vim/bundle ] || mkdir -p ~/.vim/bundle
[ ! -d ~/.vim/tags/ ] || mkdir -p ~/.vim/tags/
[ ! -d ~/.vim/dict/ ] || mkdir -p ~/.vim/dict/
[ ! -d ~/.vim/vim-ref/cache ] || mkdir -p ~/.vim/vim-ref/cache
[ ! -d ~/.vim/bundle/neobundle.vim ] || git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

# php-cs-fixerの導入
[ ! -f /usr/local/bin/php-cs-fixer ] || sudo wget http://get.sensiolabs.org/php-cs-fixer.phar -O /usr/local/bin/php-cs-fixer
sudo chmod a+x /usr/local/bin/php-cs-fixer

# PHP辞書ファイル
[ ! -f ~/.vim/dict/php.dict ] || php -r '$f=get_defined_functions();echo join("\n",$f["internal"]);'|sort > ~/.vim/dict/php.dict

# PHPマニュアル
[ ! -d ~/.vim/vim-ref/php-chunked-xhtml ] || cd ~/.vim/vim-ref && wget http://jp1.php.net/distributions/manual/php_manual_ja.tar.gz && tar -zxvf php_manual_ja.tar.gz -C ~/.vim/vim-ref 

# zsh-completions
[ ! -d $HOME/.zsh/zsh-completions ] && mkdir -p $HOME/.zsh && cd $HOME/.zsh && git clone git@github.com:zsh-users/zsh-completions.git

# antigen
[ ! -d $HOME/.zsh/antigen ] && mkdir -p $HOME/.zsh && cd $HOME/.zsh && git clone git@github.com:zsh-users/antigen.git

# ruby
which rbenv && rbenv install $RUBY_VERSION && rbenv global $RUBY_VERSION

# bundler
which rbenv && rbenv exec gem install bundler

# tmuxinatorの導入
which bundle && bundle install

# hub
[ ! -d $HOME/repos/hub ] && mkdir -p $HOME/repos && cd $HOME/repos && git clone git@github.com:github/hub.git
[ ! -f $HOME/.zsh/completions/_hub ] && cp $HOME/repos/hub/etc/hub.zsh_completion $HOME/.zsh/completions/_hub

# packer
[! -d $HOME/packer ] && mkdir -p $HOME/packer && cd $HOME/Downloads && wget -O https://releases.hashicorp.com/packer/${PAKER_VERSION}/packer_${PAKER_VERSION}_darwin_amd64.zip && unzip packer_${PAKER_VERSION}_darwin_amd64.zip -d $HOME/packer
