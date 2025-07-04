# Path to your oh-my-zsh configuration.
ZSH=/bin/zsh

export PYTHONPATH="$HOME/.venv3.13/lib/python3.13/site-packages:$PYTHONPATH"

# harmful
## ^D
setopt IGNORE_EOF
## ^Q/^S control flow
setopt NO_FLOW_CONTROL
## beep
setopt NO_BEEP

# man
function zman() {
  PAGER="less -g -s '+/^ {7}"$1"'" man zshall
}

# history
setopt SHARE_HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
## search incremental
bindkey '^r' \
  history-incremental-pattern-search-backward
bindkey '^s' \
  history-incremental-pattern-search-forward
## history-search-end
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end \
  history-search-end
bindkey '^p' history-beginning-search-backward-end

# directory
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# key bind
bindkey -e

# Edit CLI
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " '/=;@:{},|"
zstyle ':zle:*' word-style unspecified


# alias
## ls
alias ls='ls -F'
alias la='ls -a'
alias ll='ls -l'
## rm
alias rm='rm -i'
## cp
alias cp='cp -i'
## mv
alias mv='mv -i'
## mkdir
alias mkdir='mkdir -p'
## cd
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../..'
## aws logs tail
alias taildev='aws logs tail --profile auwellness_ro_dev `aws logs describe-log-groups --profile auwellness_ro_dev | jq -r ".logGroups[].logGroupName" | peco` --follow'
alias tailstg='aws logs tail --profile auwellness_ro_stg `aws logs describe-log-groups --profile auwellness_ro_stg | jq -r ".logGroups[].logGroupName" | peco` --follow'
alias tailprd='aws logs tail --profile auwellness_ro_prd `aws logs describe-log-groups --profile auwellness_ro_prd | jq -r ".logGroups[].logGroupName" | peco` --follow'
# global alias
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g N='> /dev/null'
alias -g V='| vim -R -'
alias -g P=' --help | less'
alias -g vim=/opt/local/bin/vim
alias -g vi='vim'
# exa
alias ea='exa -a'
alias el='exa -l'
alias et='exa -alT'
# aws-vault
alias avl='aws-vault'
if [[ -f $HOME/.zsh/completions/_aws-vault ]]; then
  fpath=(${HOME}/.zsh/completions $fpath)
fi
# terraform
alias tf='terraform'

# complement
## menu mode
zstyle ':completion:*:default' menu select=2
## ignore camel
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# plugins
autoload -Uz add-zsh-hook
## cdr
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 200
zstyle ':chpwd:*' recent-dirs-default true
## zmv
autoload -Uz zmv
alias zmv='noglob zmv -W'
## vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats "%F{magenta}(%s)-[%b]%f"
zstyle ':vcs_info:*' actionformats "%F{red}(%s)-[%b|%a]%f"
function _update_vcs_info_msg() {
  LANG=en_US.UTF-8 vcs_info
  #PROMPT="[${fg[green]}%n${reset_color}@${fg[blue]}%m${reset_color}] ${fg[red]}%D %*${reset_color} ${vcs_info_msg_0_} %~
#${fg[cyan]}%#${reset_color} "
  PROMPT="[%F{green}%n%f@%F{blue}%m%f] %F{red}%D %*%f ${vcs_info_msg_0_} %~
%F{cyan}%#%f "
}
add-zsh-hook precmd _update_vcs_info_msg
## antigen
if [[ -f ${HOME}/.zsh/antigen/antigen.zsh ]]; then
  source ${HOME}/.zsh/antigen/antigen.zsh
 
  ## zsh-syntax-highlighting
  antigen bundle zsh-users/zsh-syntax-highlighting
  ## zsh-completions
  antigen bundle zsh-users/zsh-completions src
  ## anyframe
  antigen bundle mollifier/anyframe
  ## tmux-mem-cpu-load
  antigen bundle thewtex/tmux-mem-cpu-load
  ## Docker autocompletion
  antigen bundle docker      

  antigen apply
fi
## hub
if [[ -f $HOME/.zsh/completions/_hub ]]; then
  eval "$(hub alias -s)"
  fpath=(${HOME}/.zsh/completions $fpath)
fi

# Anything interface by Peco
## history
function peco-execute-history() {
  builtin history -n -r 1 \
    | anyframe-selector-auto "${LBUFFER}" \
	| anyframe-action-put
}
zle -N peco-execute-history
bindkey '^x^r' peco-execute-history
## git
bindkey '^x^gcob' anyframe-widget-checkout-git-branch
bindkey '^x^gib' anyframe-widget-insert-git-branch
## tmux
### windows
function peco-tmux-windows() {
  local i=$(tmux lsw | awk '/active.$/ {print NR-1}')
  local f='#{window_index}: #{window_name}#{window_flag} #{pane_current_path}'
  tmux lsw -F "$f" \
    | anyframe-selector-auto "" --initial-index $i \
	| cut -d ':' -f 1 \
	| anyframe-action-execute tmux select-window -t
}
zle -N peco-tmux-windows
bindkey '^xtw' peco-tmux-windows

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
# plugins=(git plarailAdvance_IRkit aws)

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
export LC_ALL=ja_JP.UTF-8

# ruby
#if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi
export PATH="/usr/local/opt/ruby/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"

# added by travis gem
[ -f /Users/kitada/.travis/travis.sh ] && source /Users/kitada/.travis/travis.sh
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

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

# tmux
if ( ! test $TMUX ) && ( ! expr $TERM : "^screen" > /dev/null ) && which tmux > /dev/null; then
  if ( tmux has-session ); then
    session=`tmux list-sessions |grep -e '^[0-9].*]$'| head -n 1 | sed -e 's/^\([0-9]\+\).*$/\1/'`
	if [ -n "$session" ]; then
      echo "Attach tmux session $session."
	  tmux attach-session -t $session
	else
      echo "Session has been already attached."
	  tmux list-sessions
    fi
  else
    echo "Create new tmux session."
	tmux
  fi
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Packer
export PATH=~/packer:$PATH

# GOPATH with direnv
eval "$(direnv hook zsh)"
## GOPATH
export GOPATH="$HOME/go"
## bin
export GOBIN="$GOPATH/bin"
export PATH=$GOBIN:$PATH

# manage repos by ghq and peco
bindkey '^]' peco-src

function peco-src() {
  local src=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$src" ]; then
    BUFFER="cd $src"
    zle accept-line
  fi
  zle -R -c
}
zle -N peco-src

# anyenv
if [[ -d $HOME/.anyenv ]]; then
  export PATH=$HOME/.anyenv/bin:$PATH
  eval "$(anyenv init -)"
fi

# powerline
if ! which powerline > /dev/null; && export PATH=$HOME/.venv/bin:$PATH
powerline-daemon -q
powerline-config tmux setup
powerline-config shell command -s zsh

export PATH="/usr/local/sbin:$PATH"

export HOMEBREW_PREFIX="/usr/local"
export HOMEBREW_REPOSITORY="/usr/local"
export HOMEBREW_CELLAR="/usr/local/Cellar"
export HOMEBREW_BOTTLE_DOMAIN="https://homebrew.bintray.com"

# sshp
alias sshp='ssh -i ~/.ssh/id_rsa proper-kitada@$(aws --profile "$APP"_"$ENV"_proper --region ap-northeast-1 ec2 describe-instances | jq '\''.Reservations[].Instances[] | {ip:.PublicIpAddress, tags:.Tags[0]} | .ip + "," + .tags.Value'\'' | peco | perl -nle '\''print $1 if /([\d.]+)/'\'')'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion 

# completions
autoload -Uz compinit
compinit

# グロッビング対応
setopt nonomatch

# バージョン管理しない情報
[ -f $HOME/.zshrc_local ] && . $HOME/.zshrc_local

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kitada/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/kitada/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kitada/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/kitada/google-cloud-sdk/completion.zsh.inc'; fi

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/kitada/project/vulsan/vulsan/target_maker/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/kitada/project/vulsan/vulsan/target_maker/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/kitada/project/vulsan/vulsan/target_maker/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/kitada/project/vulsan/vulsan/target_maker/node_modules/tabtab/.completions/sls.zsh

# dein
export DEIN_DIR="$HOME/.cache/dein"

# Android Studio
export PATH=$PATH:/$HOME/Library/Android/sdk/platform-tools

# Java
export PATH=/opt/homebrew/opt/java/libexec/openjdk.jdk/Contents/Home/bin:$PATH
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
