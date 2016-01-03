# Path to your oh-my-zsh configuration.
ZSH=/bin/zsh

# harmful
## ^D
setopt IGNORE_EOF
## ^Q/^S control flow
setopt NO_FLOW_CONTROL
## beep
setopt NO_BEEP

# colors
autoload -U colors && colors

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
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# prompt
PROMPT="[${fg[green]}%n${reset_color}@${fg[blue]}%m${reset_color}] ${fg[red]}%D %*${reset_color}
${fg[cyan]}%#${reset_color} "

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
# global alias
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g N='> /dev/null'
alias -g V='| vim -R -'
alias -g P=' --help | less'

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
zstyle ':vcs_info:*' formats "${fg[magenta]}(%s)-[%b]${reset_color}"
zstyle ':vcs_info:*' actionformats "${fg[red]}(%s)-[%b|%a]${reset_color}"
function _update_vcs_info_msg() {
  LANG=en_US.UTF-8 vcs_info
  RPROMPT="${vcs_info_msg_0_} %~"
}
add-zsh-hook precmd _update_vcs_info_msg
## antigen
if [[ -f ${HOME}/.zsh/antigen/antigen.zsh ]]; then
  source ${HOME}/.zsh/antigen/antigen.zsh
 
  ## zsh-syntax-highlighting
  antigen bundle zsh-users/zsh-syntax-highlighting
  ## zsh-completions
  antigen bundle zsh-users/zsh-completions src
  ## hub
  antigen bundle github/hub
  eval "$(hub alias -s)"
  ## anyframe
  antigen bundle mollifier/anyframe

  antigen apply
fi

# Anything interface by Peco
## history
function peco-execute-history() {
  builtin history -n -r 1 \
    | anyframe-selector-auto "${LBUFFER}" \
	| anyframe-action-execute
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
plugins=(git plarailAdvance_IRkit aws)
#function git(){hub "$@"} #hub

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


# tmuxnator
[[ -s ~/.tmuxinator/scripts/tmuxintor ]] && source ~/.tmuxinator/scripts/tmuxinator

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Packer
export PATH=~/packer:$PATH

# golang
export PATH=$PATH:$GOPATH/bin

# completions
autoload -Uz compinit
compinit
