OS 		:=
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Linux)
	OS += LINUX
endif
ifeq ($(UNAME_S),Darwin)
	OS += MACOS
endif
	UNAME_P := $(shell uname -p)

clean:
	rm -rf ${HOME}/.alias
	rm -rf ${HOME}/.zshrc
	rm -rf ${HOME}/.vimrc
	rm -rf ${HOME}/.oh-my-zsh/themes/omnilink.zsh-theme
	rm -rf ${HOME}/.gitconfig
	rm -rf ${HOME}/.terraformrc
	rm -rf ${HOME}/.vscode

common:
	mkdir -p ${HOME}/.alias
	touch ${HOME}/.alias/custom_env
	ln -vsf ${PWD}/.zshrc ${HOME}/.zshrc
	ln -vsf ${PWD}/omnilink.zsh-theme ${HOME}/.oh-my-zsh/themes/omnilink.zsh-theme
	ln -vsf ${PWD}/.terraformrc ${HOME}/.terraformrc
	mkdir -p ${HOME}/.vim
	ln -vsf ${PWD}/.vimrc ${HOME}/.vimrc
	ln -vsf ${PWD}/.vim/colors ${HOME}/.vim/colors

macos: common
	ln -vsf ${PWD}/os/macos/.gitconfig ${HOME}/.gitconfig
	mkdir -p ${HOME}/.macos
	curl -L https://iterm2.com/shell_integration/zsh -o ~/.macos/.iterm2_shell_integration.zsh
	ln -vsf ${PWD}/os/macos/.zshrc ${HOME}/.macos/.zshrc

linux: common
	ln -vsf ${PWD}/os/linux/.gitconfig ${HOME}/.gitconfig
	dconf load /com/gexperts/Tilix/ < ${PWD}/.config/tilix/tilix.dconf
