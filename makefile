OS 		:=
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Linux)
	OS += LINUX
endif
ifeq ($(UNAME_S),Darwin)
	OS += OSX
endif
	UNAME_P := $(shell uname -p)

clean:
	rm -rf ${HOME}/.alias
	rm -rf ${HOME}/.zshrc
	rm -rf ${HOME}/.vimrc
	rm -rf ${HOME}/.oh-my-zsh/themes/omnilink.zsh-theme
	rm -rf ${HOME}/.docker
	rm -rf ${HOME}/.gitconfig
	rm -rf ${HOME}/.terraformrc
	rm -rf ${HOME}/.vscode

common:
	mkdir -p ${HOME}/.alias
	touch ${HOME}/.alias/custom_env
	ln -vsf ${PWD}/.zshrc ${HOME}/.zshrc
	ln -vsf ${PWD}/omnilink.zsh-theme ${HOME}/.oh-my-zsh/themes/omnilink.zsh-theme
	mkdir -p ${HOME}/.docker
	ln -vsf  ${PWD}/.docker/config.json ${HOME}/.docker/config.json
	ln -vsf ${PWD}/.terraformrc ${HOME}/.terraformrc
	mkdir -p ${HOME}/.vim
	ln -vsf ${PWD}/.vimrc ${HOME}/.vimrc
	ln -vsf ${PWD}/.vim/colors ${HOME}/.vim/colors

osx: common
	ln -vsf ${PWD}/.gitconfig ${HOME}/.gitconfig
	curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
	ln -vsf ${PWD}/.vscode/settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json
	ln -vsf ${PWD}/os/osx/.gitconfig ${HOME}/.gitconfig

linux: common
	ln -vsf ${PWD}/os/linux/.gitconfig ${HOME}/.gitconfig
