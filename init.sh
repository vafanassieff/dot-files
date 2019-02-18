#!/bin/bash

set -e

if [ "$(uname)" == "Darwin" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sudo apt install zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
