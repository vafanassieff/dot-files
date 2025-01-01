export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git docker encode64 zsh-autosuggestions zsh-syntax-highlighting you-should-use zsh-bat)
source $ZSH/oh-my-zsh.sh

# Path
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export SOPS_AGE_KEY_FILE="$HOME/.age/key"

export EDITOR="cursor --wait"

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

# Alias
alias c='clear'
alias ll='ls -la'
alias zshsource="source ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias busy="cat /dev/urandom | hexdump -C | grep 'ca fe'" 
alias sshpwd="ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no"
alias cp="rsync --archive --progress --human-readable --info=progress2"
alias cat="bat"
alias dc="docker compose"
alias dps='docker ps --format "table {{.Names}}\t{{.RunningFor}}\t{{.Status}}"'

# Stupid Alias
alias vin="vim"
alias docket="docker"
alias giut="git"
alias rm="rm -I"

unsetopt inc_append_history
unsetopt share_history

function stream-twitch() {
	streamlink --player="/Applications/VLC.app/Contents/MacOS/VLC --file-caching 10000 --network-caching 10000" \
	--hls-segment-threads 2 https://www.twitch.tv/$1 best
}

function rm-ssh-host () {
	sed -i '' -e "$1d" ~/.ssh/known_hosts
}

eval "$(fnm env --use-on-cd)"
eval "$(atuin init zsh)"

# pnpm
export PNPM_HOME="/Users/afa/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# fnm
FNM_PATH="/Users/afa/Library/Application Support/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/Users/afa/Library/Application Support/fnm:$PATH"
  eval "`fnm env`"
fi
