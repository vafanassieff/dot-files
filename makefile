init:
	ln -vsf ${PWD}/.zshrc   ${HOME}/.zshrc
	ln -vsf ${PWD}/.vimrc   ${HOME}/.vimrc

docker:
	sudo usermod -aG docker ${USER}
	mkdir -p ${HOME}/.docker
	ln -vsf  ${PWD}/.docker/config.json   ${HOME}/.docker/config.json
	sudo systemctl enable docker.service
	sudo systemctl start docker.service
