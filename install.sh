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

  curl -fsSL https://get.pnpm.io/install.sh | sh -
  curl -fsSL https://fnm.vercel.app/install | bash
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
  curl -sS https://starship.rs/install.sh | sh
  sudo apt-get install -y rsync bat lsd fish git age jq wget htop
  sudo ln -vsf /usr/bin/batcat /usr/local/bin/bat
fi

ln -vsf $PWD/starship.toml $HOME/.config/starship.toml

# Setup vim
rm -rf $HOME/.vimrc
ln -vsf $PWD/.vimrc $HOME/.vimrc
mkdir -p $HOME/.vim 
ln -vsf $PWD/.vim/colors $HOME/.vim/colors

mkdir -p "$HOME/.config/fish"
ln -vsf $PWD/config.fish "$HOME/.config/fish/config.fish"

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
