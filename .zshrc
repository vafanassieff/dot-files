
export ZSH=/home/omnilink/.oh-my-zsh
ZSH_THEME="omnilink"
unsetopt inc_append_history
unsetopt share_history
source $ZSH/oh-my-zsh.sh

# Env

export PATH=$PATH:~/bin
export ZSH="/home/omnilink/.oh-my-zsh"

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
