if string match -q -- "Linux" (uname)
  set -gx PNPM_HOME "/home/afa/.local/share/pnpm"
end

if string match -q -- "Darwin" (uname)
  set -x PATH /opt/homebrew/bin $PATH
  set -gx PNPM_HOME "/Users/afa/Library/pnpm"
end

if status is-interactive
  atuin init fish | sed 's/-k up/up/' | source
end

# Disable greeting
set fish_greeting

direnv hook fish | source

set -x LANG en_US.UTF-8

# Replace fish-abbreviation-tips emoji prefix — Zed terminal mojibake on multi-byte
# unicode (https://github.com/zed-industries/zed/issues/19833,
# https://github.com/zed-industries/zed/issues/37160).
set -U ABBR_TIPS_PROMPT '\n→ \e[1m{{ .abbr }}\e[0m => {{ .cmd }}'
set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x PATH $HOME/.atuin/bin $PATH
set -x SOPS_AGE_KEY_FILE $HOME/.age/key
set -x SOPS_AGE_SSH_PRIVATE_KEY_FILE $HOME/.ssh/id_victor
set -x EDITOR "zed --wait"
set -x HOMEBREW_NO_ANALYTICS 1
set -x GPG_TTY (tty)
set -gx DIRENV_LOG_FORMAT ""

starship init fish | source

if string match -q -- "Darwin" (uname)
  mise activate fish | source
end

if not string match -q -- $PNPM_HOME $PATH
set -x PATH /opt/homebrew/bin $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

# Alias
alias cat='bat'
alias ls='lsd'
alias c='clear'
alias ll='ls -la'
alias busy='cat /dev/urandom | hexdump -C | grep "ca fe"'
alias sshpwd='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'
alias cp='rsync --archive --progress --human-readable'
alias dc='docker compose'
alias dps='docker ps --format "table {{.Names}}\t{{.RunningFor}}\t{{.Status}}"'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.fish 2>/dev/null || :

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
