# Env

export PATH=$PATH:~/bin
export ZSH="/home/omnilink/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

ZSH_THEME="omnilink"

plugins=(
  git
)

## Alias

alias c='clear'
alias ll='ls -la'
alias zconf='vim ~/.zshrc'
alias vconf='vim ~/.vimrc'
alias zshsource="source ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias tips="vim ~/nas/tips.md"
alias btc-log="tail -f /crypto/bitcoin/debug.log"
alias docker-ip="ocker ps -q | xargs -n 1 docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} {{ .Name }}' | sed 's/ \// /'"
alias dc="docker-compose"

## Functions

traefik-pwd () {
  htpasswd -nb $1 $2 | sed -e s/\\$/\\$\\$/g
}
