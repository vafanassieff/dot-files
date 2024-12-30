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
	rm -rf ${HOME}/.zshrc
	rm -rf ${HOME}/.vimrc
	rm -rf ${HOME}/.gitconfig
	rm -rf ${HOME}/.vscode

common:
	ln -vsf ${PWD}/.zshrc ${HOME}/.zshrc
	mkdir -p ${HOME}/.vim
	ln -vsf ${PWD}/.vimrc ${HOME}/.vimrc
	ln -vsf ${PWD}/.vim/colors ${HOME}/.vim/colors

macos: common
	ln -vsf ${PWD}/os/macos/.gitconfig ${HOME}/.gitconfig

linux: common
	ln -vsf ${PWD}/os/linux/.gitconfig ${HOME}/.gitconfig
