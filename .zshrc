# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="amuse"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias less="less -R"
alias jmeter="~/apache-jmeter-2.11/bin/jmeter"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git,plarailAdvance_IRkit)
function git(){hub "$@"} #hub

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:/usr/local/bin:/usr/local/opt/coreutils/libexec/gnubin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export LANG=ja_JP.UTF-8

# ruby
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi


# ec2
export JAVA_HOME=$(/usr/libexec/java_home)
export EC2_HOME=/usr/local/ec2/ec2-api-tools-1.6.14.1
export PATH=$PATH:$EC2_HOME/bin 
export AWS_SECRET_KEY="TktIxQxIfSKQzu2jlVwm0xffpGZr2hav"
export AWS_SECRET_KEY="hQnTAhk/TktIxQxIfSKQzu2jlVwm0xffpGZr2hav"
export BOXEN_GITHUB_LOGIN="kitatuba"

# added by travis gem
[ -f /Users/kitada/.travis/travis.sh ] && source /Users/kitada/.travis/travis.sh
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# ctags
alias ctags="`brew --prefix`/bin/ctags"
tagsCmd='ctags --languages=php -f'
tagsVariable=''
tagsVariableBEF=$tagsVariable"$tagsCmd $HOME/.vim/tags/kittyhawk.tags $HOME/vagrants/lucky-aws/kittyhawk;"
tagsVariableCoupy=$tagsVariable"$tagsCmd $HOME/.vim/tags/coupy.tags $HOME/vagrants/lucky-aws/coupy;"
tagsVariableWDG=$tagsVariable"$tagsCmd $HOME/.vim/tags/au-blinkfeed.tags $HOME/project/au-blinkfeed/au-blinkfeed;"
alias TAGS_BEF=$tagsVariableBEF
alias TAGS_WDG=$tagsVariableWDG 
alias TAGS_BEF-CMS=$tagsVariableCoupy

# predict
#autoload -U predict-on
#predict-on

# pain間のhistory共有
setopt SHARE_HISTORY

# directory
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# zsh-completions
fpath=($HOME/.zsh/zsh-completions/src(N-/) $fpath)

autoload -Uz compinit
compinit

# tmuxnator
[[ -s ~/.tmuxinator/scripts/tmuxintor ]] && source ~/.tmuxinator/scripts/tmuxinator

# crontab対策
export EDITOR=/usr/local/bin/vim

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
