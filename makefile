nas-dot-file:
	ln -vsf ${PWD}/.zshrc   ${HOME}/.zshrc
	ln -vsf ${PWD}/.vimrc   ${HOME}/.vimrc
	ln -vsf ${PWD}/omnilink.zsh-theme   ${HOME}/.oh-my-zsh/omnilink.zsh-theme

docker:
	sudo usermod -aG docker ${USER}
	mkdir -p ${HOME}/.docker
	ln -vsf  ${PWD}/.docker/config.json   ${HOME}/.docker/config.json
	sudo systemctl enable docker.service
	sudo systemctl start docker.service
