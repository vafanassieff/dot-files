#!/bin/bash

if [ "$1" == "export" ]; then
    code --list-extensions > ./extensions
    echo "√ Export done"
fi

if [ "$1" == "install" ]; then
    for l in $(<extensions); do 
        code --install-extension $l 
    done
fi

