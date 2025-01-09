set -x PATH /opt/homebrew/bin $PATH

if status is-interactive
  atuin init fish | source
end

# Disable greeting
set fish_greeting

set -x LANG en_US.UTF-8
set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x PATH $HOME/.local/share/fnm $PATH
set -x PATH $HOME/.atuin/bin $PATH
set -x SOPS_AGE_KEY_FILE $HOME/.age/key
set -x EDITOR "cursor --wait"
set -x HOMEBREW_NO_ANALYTICS 1
set -x GPG_TTY (tty)

starship init fish | source
fnm env --use-on-cd --shell fish | source

if string match -q -- "Linux" (uname)
  set -gx PNPM_HOME "/home/afa/.local/share/pnpm"
end

if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

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
alias "..."='cd ../..'
alias "...."='cd ../../..'
alias "....."='cd ../../../..'
alias rm='rm -I'
alias yarn="corepack yarn"
alias yarnpkg="corepack yarnpkg"
alias pnpm="corepack pnpm"
alias pnpx="corepack pnpx"
alias npm="corepack npm"
alias npx="corepack npx"
