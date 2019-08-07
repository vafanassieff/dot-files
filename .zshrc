
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

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

## Alias

alias c='clear'
alias ll='ls -la'
alias zconf='vim ~/.zshrc'
alias vconf='vim ~/.vimrc'
alias zshsource="source ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias docker-ip="docker ps -q | xargs -n 1 docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} {{ .Name }}' | sed 's/ \// /'"
alias docker-ls="docker container ls --format='table {{.Names}}\t{{.ID}}\t{{.Image}}'"
alias dc="docker-compose"
alias dc-dev="docker-compose -f docker-compose.dev.yml"

# Stupid Alias

alias vin="vim"
alias docket="docker"

if [ -f "$HOME/.alias/ssh_gcp" ]; then
	source $HOME/.alias/ssh_gcp
fi

if [ -f "$HOME/.alias/custom_env" ]; then
	source $HOME/.alias/custom_env
fi

## Functions

my-ip() {
  curl http://www.ip-api.com/json/ | jq
}

traefik-pwd() {
  htpasswd -nb $1 $2 | sed -e s/\\$/\\$\\$/g
}

dayms() {
  date -r $(($1 / 1000))
  }

dayus() {
  date -r $(($1 / 1000000))
  }

day() {
  date -r $1
}

refresh-gcp () {
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

docker-reset-logf () {
	if [ -z "$1"];then
  	echo "" > $(docker inspect --format='{{.LogPath}}' $1)
	fi
}

docke-ip () {
	docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
}

ctop () {
	docker run --rm -ti \
  	--name=ctop \
  	--volume /var/run/docker.sock:/var/run/docker.sock:ro \
  	quay.io/vektorlab/ctop:latest -s cpu -a
}

function dex-fn {
	docker exec -it $1 /bin/bash
}

function gdrive_download () {
  CONFIRM=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=$1" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')
  wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$CONFIRM&id=$1" -O $2
  rm -rf /tmp/cookies.txt
}

unsetopt share_history
setopt no_share_history
unsetopt SHARE_HISTORY
unsetopt inc_append_history
unsetopt share_history

source ~/.iterm2_shell_integration.zsh
