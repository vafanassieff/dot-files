export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="omnilink"
source $ZSH/oh-my-zsh.sh
plugins=(git brew docker extract)

if [ -f "~/.macos/.iterm2_shell_integration.zsh" ]; then
  source ~/.macos/.iterm2_shell_integration.zsh
fi

if [ -f "~/.macos/.zshrc" ]; then
  source ~/.macos/.zshrc
fi

# Path
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# Env
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export HOMEBREW_NO_ANALYTICS=1
export GPG_TTY=$(tty)

# Manpage color
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# pnpm
export PNPM_HOME="/Users/afa/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

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
alias rm="rm -I"

## Functions
function clear-history {
	local HISTSIZE=0;
}

function stream-twitch() {
	streamlink --player="/Applications/VLC.app/Contents/MacOS/VLC --file-caching 10000 --network-caching 10000" \
	--hls-segment-threads 2 https://www.twitch.tv/$1 best
}

function rm-ssh-host () {
	sed -i '' -e "$1d" ~/.ssh/known_hosts
}

unsetopt inc_append_history
unsetopt share_history

eval "$(fnm env --use-on-cd)"
