STOW_DIRS  = git vim zsh irb todo
VIM_DIR    = vim/.vim
VUNDLE_DIR = $(VIM_DIR)/bundle/Vundle.vim
VUNDLE_URL = https://github.com/VundleVim/Vundle.vim.git

uninstall:
	@stow -D $(STOW_DIRS) -t ~
	@stow -D stow -t ~
	@echo 'dotfiles uninstalled'

install: install-vundle
	@stow -S stow -t ~
	@stow -S $(STOW_DIRS) -t ~
	@echo 'dotfiles installed'

install-vundle:
	@git fetch -q origin
	@git pull -q --rebase
	@if [ -d "$(VUNDLE_DIR)" ]; then\
		(cd $(VUNDLE_DIR); git pull -q --rebase);\
	else\
		git clone $(VUNDLE_URL) $(VUNDLE_DIR);\
	fi
	@vim +PluginClean! +qall
	@vim +PluginInstall! +qall

clean:
	@rm -rf $(VIM_DIR)
