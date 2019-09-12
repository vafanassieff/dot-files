
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="omnilink"
source $ZSH/oh-my-zsh.sh

plugins=(git docker encode64 brew)

# Env

export MAIL42=vafanass@student.42.fr
export USER42=vafanass

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export DOTNET_CLI_TELEMETRY_OPTOUT=1
export PATH=$PATH:~/bin
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
export NODE_ENV="dev"
export DATA_ENV="dev"
export ENV="dev"
export HOMEBREW_NO_ANALYTICS=1
export COMPOSE_IGNORE_ORPHANS=True

# Manpage color
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

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
alias nextcloud-scan="docker exec --user www-data -it nextcloud php occ files:scan --all"
alias lncli-testnet="docker exec --user lnd -it lnd lncli --network testnet"
alias lncli="docker exec --user lnd -it lnd lncli"
alias transmission-remote="docker exec -it transmission transmission-remote"
alias ctop="docker run --rm -ti --name=ctop --volume /var/run/docker.sock:/var/run/docker.sock:ro quay.io/vektorlab/ctop:latest -s cpu -a"

# Stupid Alias
alias vin="vim"
alias docket="docker"

if [ -f "$HOME/.alias/ssh_gcp" ]; then
	source $HOME/.alias/ssh_gcp
fi

if [ -f "$HOME/.alias/ssh_belem_gcp" ]; then
	source $HOME/.alias/ssh_belem_gcp
fi

if [ -f "$HOME/.alias/custom_env" ]; then
	source $HOME/.alias/custom_env
fi

## Functions
function cdls() {
	cd "$1";
	ls;
}

function b64decode {
	echo $1 | base64 --decode
}

function gen-pwd {
	echo $1
	if [ -n "$1" ];then
		SIZE=$1
	fi
	openssl rand -base64 32 | tr -d "=+/" | cut -c1-${SIZE}
}

function gitm() {
	git commit -m "$1"
}

function my-ip() {
  curl http://www.ip-api.com/json/ | jq
}

function traefik-pwd() {
  htpasswd -nb $1 $2 | sed -e s/\\$/\\$\\$/g
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

function refresh-gcp () {
	rm -f ~/.gcp.tmp
	gcloud compute instances list --format json > ~/.gcp.tmp
	COUNT=$(cat ~/.gcp.tmp | jq length)
	echo Got $COUNT Google Cloud Plateform instance

	COUNT=`expr $COUNT - 1`
	a=0
	ALL_CMD=""

	while [[ $a -le $COUNT ]]
	do
		echo "Creating alias for" $(cat ~/.gcp.tmp| jq --argjson a "$a" -r -c '.[$a].name')
		SSH_CMD=$(cat ~/.gcp.tmp| jq --argjson a "$a" -r -c '"alias ssh-gcp_" + .[$a].name + "=!ssh afa@" + .[$a].networkInterfaces [0].accessConfigs[0].natIP + " -i ~/.ssh/id_omnilink!"' | tr ! \')
		ALL_CMD="$ALL_CMD$SSH_CMD\n"
    	a=`expr $a + 1`
	done

	echo $ALL_CMD > ~/.alias/ssh_gcp
	echo Source new gcp ssh alias
	source ~/.alias/ssh_gcp
	rm -f ~/.gcp.tmp
	echo Done √
}

function docker-ip {
	docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
}

function docker-reset-logf () {
	if [ -z "$1"];then
  	echo "" > $(docker inspect --format='{{.LogPath}}' $1)
	fi
}

function dex-fn {
	docker exec -it $1 /bin/bash
}

function gdrive_download () {
  CONFIRM=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=$1" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')
  wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$CONFIRM&id=$1" -O $2
  rm -rf /tmp/cookies.txt
}

function delete-osx-useless {
	if [$(uname) != "Darwin"]; then
		find . -name '._*' -type f
		find . -name '._*' -type f -delete
		find . -name '.DS_Store' -type f
		find . -name '.DS_Store' -type f -delete
	fi
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

unsetopt share_history
setopt no_share_history
unsetopt SHARE_HISTORY
unsetopt inc_append_history

source ~/.iterm2_shell_integration.zsh
