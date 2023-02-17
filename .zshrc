export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000

setopt appendhistory
setopt no_share_history
unsetopt share_history

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="omnilink"
source $ZSH/oh-my-zsh.sh

if [ -f "~/.iterm2_shell_integration.zsh" ]; then
  source ~/.iterm2_shell_integration.zsh
fi

plugins=(git brew)

# Path
export NVM_DIR="$HOME/.nvm"
export PATH="$HOME/.cargo/bin:$PATH"
export PNPM_HOME="/Users/omnilink/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Env
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export HOMEBREW_NO_ANALYTICS=1

# Manpage color
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Alias
alias c='clear'
alias ll='ls -la'
alias zconf='vim ~/.zshrc'
alias vconf='vim ~/.vimrc'
alias zshsource="source ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias tf="terraform"
alias rmdir="rm -r"
alias busy="cat /dev/urandom | hexdump -C | grep 'ca fe'" 
alias sshpwd="ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no"

# Git related
alias gs='git status'
alias gc='git commit'
alias ga='git add'
alias gd='git diff'
alias gb='git branch'
alias gl='git log'
alias gsb='git show-branch'
alias gco='git checkout'
alias gg='git grep'
alias gk='gitk --all'
alias gr='git rebase'
alias gri='git rebase --interactive'
alias gcp='git cherry-pick'
alias grm='git rm'
alias gp="git push"

# Docker Alias
alias lncli-testnet="docker exec --user satoshi -it lnd_testnet lncli --network testnet"
alias lncli="docker exec --user satoshi -it lnd lncli"
alias dc="docker compose"

# Stupid Alias
alias vin="vim"
alias docket="docker"
alias giut="git"

## Functions
function clear_history {
	local HISTSIZE=0;
}

function stream-twitch() {
	streamlink --player="/Applications/VLC.app/Contents/MacOS/VLC --file-caching 10000 --network-caching 10000" \
	--hls-segment-threads 2 https://www.twitch.tv/$1 best
}

function extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

function rm-ssh-host () {
	sed -i '' -e "$1d" ~/.ssh/known_hosts
}
