#!/usr/bin/env bash

OS=$(uname -s)

echo "Running the installer for $OS"

if [ "$OS" == "Darwin" ]; then
  rm -rf $HOME/.gitconfig
  ln -vsf $PWD/macos/.gitconfig $HOME/.gitconfig
  brew bundle --file=$PWD/macos/Brewfile

  mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"
  ln -vsf $PWD/ghostty "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
fi

if [ "$OS" == "Linux" ]; then
  rm -rf $HOME/.gitconfig
  ln -vsf $PWD/linux/.gitconfig $HOME/.gitconfig

  if ! command -v pnpm &> /dev/null; then
    curl -fsSL https://get.pnpm.io/install.sh | sh -
  fi

  if ! command -v mise &> /dev/null; then
    curl https://mise.run | sh
  fi

  if ! command -v atuin &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
  fi

  if ! command -v starship &> /dev/null; then
    curl -sS https://starship.rs/install.sh | sh
  fi

  sudo apt-get install -y rsync bat lsd fish git age jq wget htop
  
  sudo ln -vsf /usr/bin/batcat /usr/local/bin/bat
fi

ln -vsf $PWD/starship.toml $HOME/.config/starship.toml

# Setup mise
mkdir -p "$HOME/.config/mise"
ln -vsf $PWD/mise/config.toml "$HOME/.config/mise/config.toml"
mise install

# Setup vim
rm -rf $HOME/.vimrc
ln -vsf $PWD/.vimrc $HOME/.vimrc
mkdir -p $HOME/.vim 
ln -vsf $PWD/.vim/colors $HOME/.vim/colors

mkdir -p "$HOME/.config/fish"
ln -vsf $PWD/config.fish "$HOME/.config/fish/config.fish"

# Setup shell rc
ln -vsf $PWD/.zprofile $HOME/.zprofile
ln -vsf $PWD/.zshenv $HOME/.zshenv
ln -vsf $PWD/.bashrc $HOME/.bashrc
ln -vsf $PWD/.profile $HOME/.profile

# Setup misc config
mkdir -p "$HOME/.config/git" "$HOME/.config/lf" "$HOME/.config/direnv" "$HOME/.config/atuin"
ln -vsf $PWD/git/ignore "$HOME/.config/git/ignore"
ln -vsf $PWD/lf/lfrc "$HOME/.config/lf/lfrc"
ln -vsf $PWD/direnv/direnv.toml "$HOME/.config/direnv/direnv.toml"
ln -vsf $PWD/atuin/config.toml "$HOME/.config/atuin/config.toml"

# Setup zed
mkdir -p "$HOME/.config/zed/themes"
ln -vsf $PWD/zed/settings.json "$HOME/.config/zed/settings.json"
ln -vsf $PWD/zed/keymap.json "$HOME/.config/zed/keymap.json"
ln -vsf $PWD/zed/themes/afa-dark.json "$HOME/.config/zed/themes/afa-dark.json"

# https://pnpm.io/completion
if ! command -v pnpm &> /dev/null; then
  pnpm completion fish > ~/.config/fish/completions/pnpm.fish
fi

# https://github.com/jorgebucaran/fisher
if ! command -v fisher &> /dev/null; then
  exec fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fi

# https://github.com/jhillyerd/plugin-git
exec fish -c "fisher install jhillyerd/plugin-git"
exec fish -c "fisher install jethrokuan/z"
exec fish -c "fisher install laughedelic/pisces"
exec fish -c "fisher install gazorby/fish-abbreviation-tips"
