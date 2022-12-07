
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="omnilink"
source $ZSH/oh-my-zsh.sh

if [ -f "~/.iterm2_shell_integration.zsh" ]; then
  source ~/.iterm2_shell_integration.zsh
fi

plugins=(git encode64 brew)

# Path
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:~/bin
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/qt/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH=$PATH:$GOPATH/bin
export PATH="/usr/local/opt/tcl-tk/bin:$PATH"
export PNPM_HOME="/Users/omnilink/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# Env
export MAIL42=vafanass@student.42.fr
export USER42=vafanass
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
alias git-update-submodule="git submodule foreach git pull origin master"
alias tf="terraform"
alias tf-init="terraform init -plugin-dir ~/.terraform.d/plugin-cache/darwin_amd64 "
alias rmdir="rm -r"
alias port='netstat -tulanp'
alias busy="cat /dev/urandom | hexdump -C | grep 'ca fe'" 
alias sshpwd="ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no"
alias ff-work="nohup /Applications/Firefox.app/Contents/MacOS/firefox-bin -P LNMarkets -no-remote > /dev/null 2>&1 &"

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
alias docker-ls="docker container ls --format='table {{.Names}}\t{{.ID}}\t{{.Image}}'"
alias dc="docker-compose"
alias dc-dev="docker-compose -f docker-compose.dev.yml"
alias lncli-testnet="docker exec --user satoshi -it lnd_testnet lncli --network testnet"
alias lncli="docker exec --user satoshi -it lnd lncli"
alias transmission-remote="docker exec -it transmission transmission-remote"
alias ctop="docker run --rm -ti --name=ctop --volume /var/run/docker.sock:/var/run/docker.sock:ro quay.io/vektorlab/ctop:latest -s cpu -a"
alias docker-networl-cidr="docker network inspect $(docker network ls | awk '$3 == "bridge" { print $1}') | jq -r '.[] | .Name + " " + .IPAM.Config[0].Subnet' -"

# Stupid Alias
alias vin="vim"
alias docket="docker"
alias giut="git"

for f in ~/.alias/*; do source $f; done

case "$OSTYPE" in
   cygwin*)
      alias open="cmd /c start"
      ;;
   linux*)
      alias start="xdg-open"
      alias open="xdg-open"
      ;;
   darwin*)
      alias start="open"
      ;;
esac

## Functions
function clear_history {
	local HISTSIZE=0;
}

function stream-twitch() {
	streamlink --player="/Applications/VLC.app/Contents/MacOS/VLC --file-caching 10000 --network-caching 10000" \
	--hls-segment-threads 2 https://www.twitch.tv/$1 best
}

function cdls() {
	cd "$1";
	ls;
}

function b64decode {
	echo $1 | base64 --decode
}

function gitm() {
	git commit -m "$1"
}

function my-ip() {
  curl http://www.ip-api.com/json/ | jq
}

function dayms() {
  date -r $(($1 / 1000))
  }

function dayus() {
  date -r $(($1 / 1000000))
  }

function day() {
  date -r $1
}

function docker-ip {
	docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
}

function gdrive_download () {
  CONFIRM=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=$1" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')
  wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$CONFIRM&id=$1" -O $2
  rm -rf /tmp/cookies.txt
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

unsetopt share_history
setopt no_share_history
unsetopt SHARE_HISTORY
unsetopt inc_append_history

# pnpm
export PNPM_HOME="/Users/omnilink/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

