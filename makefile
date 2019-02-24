dot-file:
	mkdir -p ${HOME}/.alias
	touch ${HOME}/.alias/ssh_gcp
	touch ${HOME}/.alias/custom_env
	ln -vsf ${PWD}/.zshrc ${HOME}/.zshrc
	ln -vsf ${PWD}/.vimrc ${HOME}/.vimrc
	ln -vsf ${PWD}/omnilink.zsh-theme ${HOME}/.oh-my-zsh/themes/omnilink.zsh-theme
	mkdir -p ${HOME}/.docker
	ln -vsf  ${PWD}/.docker/config.json ${HOME}/.docker/config.json

git:
	git config --global user.name "Victor Afanassieff"
	git config --global user.email "victor@afanassieff.com"

42:
	mkdir -p ${HOME}/goinfre/VirtualBox\ Vms
	ln -vsf ${HOME}/goinfre/VirtualBox\ Vms ${HOME}/VirtualBox\ VMs
	mkdir -p ${HOME}/goinfre/docker/com.docker.docker
	ln -vsf ${HOME}/goinfre/docker/com.docker.docker ${HOME}/Library/Containers/com.docker.docker

42-clean:
	rm -rf ${HOME}/goinfre/VirtualBox\ Vms
	rm -rf ${HOME}/VirtualBox\ VMs
	rm -rf ${HOME}/goinfre/docker/com.docker.docker
	rm -rf ${HOME}/Library/Containers/com.docker.docker

vim:
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim | true
	git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized | true

docker:
	sudo usermod -aG docker ${USER}
	sudo systemctl enable docker.service
	sudo systemctl start docker.service

all: dot-file vim

clean-dot-file:
	rm -rf ${HOME}/.alias
	rm -rf ${HOME}/.zshrc
	rm -rf ${HOME}/.vimrc
	rm -rf ${HOME}/.oh-my-zsh/themes/omnilink.zsh-theme
	rm -rf ${HOME}/.docker

clean: clean-dot-file

re: clean all

ssh-server:
	echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKuKqJf8l+LQTl0NpSBuT9Ln7b7LRH4zxAJRgP9BUPpG victor@afanassieff.com" >> ~/.ssh/authorized_keys
