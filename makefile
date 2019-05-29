OS 		:=
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Linux)
	OS += LINUX
endif
ifeq ($(UNAME_S),Darwin)
	OS += OSX
endif
	UNAME_P := $(shell uname -p)

all: vim dot-file

re: clean all

clean:
	rm -rf ${HOME}/.alias
	rm -rf ${HOME}/.zshrc
	rm -rf ${HOME}/.vimrc
	rm -rf ${HOME}/.oh-my-zsh/themes/omnilink.zsh-theme
	rm -rf ${HOME}/.docker

zsh:
	if [ $(OS) == "OSX" ]; then brew install zsh; fi;
	if [ $(OS) == "LINUX" ]; then sudo apt-getinstall -y zsh; fi;
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

dot-file:
	mkdir -p ${HOME}/.alias
	touch ${HOME}/.alias/ssh_gcp
	touch ${HOME}/.alias/custom_env
	ln -vsf ${PWD}/.zshrc ${HOME}/.zshrc
	ln -vsf ${PWD}/.vimrc ${HOME}/.vimrc
	ln -vsf ${PWD}/omnilink.zsh-theme ${HOME}/.oh-my-zsh/themes/omnilink.zsh-theme
	mkdir -p ${HOME}/.docker
	ln -vsf  ${PWD}/.docker/config.json ${HOME}/.docker/config.json
	# Not all computer are mac quick hack to avoid error
	ln -vsf ${PWD}/.vscode/settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json | true
	ln -vsf ${PWD}/.gitconfig ${HOME}/.gitconfig

# Config specific for 42 school Imac
42:
	mkdir -p ${HOME}/goinfre/VirtualBox\ Vms
	ln -vsf ${HOME}/goinfre/VirtualBox\ Vms ${HOME}/VirtualBox\ VMs
	mkdir -p ${HOME}/goinfre/docker/com.docker.docker
	ln -vsf ${HOME}/goinfre/docker/com.docker.docker ${HOME}/Library/Containers/com.docker.docker
	mkdir -p ${HOME}/goinfre/docker/docker-machine
	ln -vsf ${HOME}/goinfre/docker/docker-machine ${HOME}/.docker/machine

# Clean the current 42 imac
42-clean:
	rm -rf ${HOME}/goinfre/VirtualBox\ Vms
	rm -rf ${HOME}/VirtualBox\ VMs
	rm -rf ${HOME}/goinfre/docker/com.docker.docker
	rm -rf ${HOME}/Library/Containers/com.docker.docker
	rm -rf ${HOME}/.docker/machine
	rm -rf ${HOME}/goinfre/docker/docker-machine

vim:
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim | true
	git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized | true

docker:
	sudo usermod -aG docker ${USER}
	sudo systemctl enable docker.service
	sudo systemctl start docker.service

ssh-key:
	echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKuKqJf8l+LQTl0NpSBuT9Ln7b7LRH4zxAJRgP9BUPpG victor@afanassieff.com" >> ~/.ssh/authorized_keys
