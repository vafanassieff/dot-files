dot-file:
	mkdir -p ${HOME}/.alias
	touch ${HOME}/.alias/ssh_gcp
	touch ${HOME}/.alias/custom_env
	ln -vsf ${PWD}/.zshrc ${HOME}/.zshrc
	ln -vsf ${PWD}/.vimrc ${HOME}/.vimrc
	ln -vsf ${PWD}/omnilink.zsh-theme ${HOME}/.oh-my-zsh/themes/omnilink.zsh-theme
	mkdir -p ${HOME}/.docker
	ln -vsf  ${PWD}/.docker/config.json ${HOME}/.docker/config.json
	source ${HOME}/.zshrc

vim:
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim


docker:
	sudo usermod -aG docker ${USER}
	sudo systemctl enable docker.service
	sudo systemctl start docker.service

all: dot-file vim
