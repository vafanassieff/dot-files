set -x PATH /opt/homebrew/bin $PATH

if status is-interactive
  atuin init fish | source
end

starship init fish | source
fnm env --use-on-cd --shell fish | source

# Disable greeting
set fish_greeting

set -x LANG en_US.UTF-8
set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $HOME/bin $PATH
set -x SOPS_AGE_KEY_FILE $HOME/.age/key
set -x EDITOR "cursor --wait"
set -x HOMEBREW_NO_ANALYTICS 1
set -x GPG_TTY (tty)

# Alias
alias cat='bat'
alias ls='lsd'
alias c='clear'
alias ll='ls -la'
alias busy='cat /dev/urandom | hexdump -C | grep "ca fe"'
alias sshpwd='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'
alias cp='rsync --archive --progress --human-readable --info=progress2'
alias dc='docker compose'
alias dps='docker ps --format "table {{.Names}}\t{{.RunningFor}}\t{{.Status}}"'

# Stupid Alias
alias vin='vim'
alias docket='docker'
alias giut='git'
alias rm='rm -I'
