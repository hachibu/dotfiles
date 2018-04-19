STOW_DIRS  = darksky git stow vim zsh
VIM_DIR    = vim/.vim
VUNDLE_DIR = $(VIM_DIR)/bundle/Vundle.vim
VUNDLE_URL = https://github.com/VundleVim/Vundle.vim.git

uninstall:
	stow -D $(STOW_DIRS) -t ~
	sudo stow -D etc -t /etc

install: install-vundle
	stow -S $(STOW_DIRS) -t ~
	sudo stow -S etc -t /etc

install-vundle:
	@if [ -d "$(VUNDLE_DIR)" ]; then\
		(cd $(VUNDLE_DIR); git pull --rebase);\
	else\
		git clone $(VUNDLE_URL) $(VUNDLE_DIR);\
	fi
	@vim +PluginInstall! +qall

clean:
	rm -rf $(VIM_DIR)
