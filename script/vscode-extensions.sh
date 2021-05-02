#!/usr/bin/env bash

if [ "$1" == "export" ]; then
    code --list-extensions > .vscode/extensions
    echo "√ Export done"
fi

if [ "$1" == "install" ]; then
    for l in $(<.vscode/extensions); do 
        code --install-extension $l 
    done
fi

