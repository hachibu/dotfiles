STOW_DIRS  = git vim zsh

.PHONY: install
install:
	@stow -S stow -t ~
	@stow -S $(STOW_DIRS) -t ~
	@echo 'dotfiles installed'

.PHONY: uninstall
uninstall:
	@stow -D $(STOW_DIRS) -t ~
	@stow -D stow -t ~
	@echo 'dotfiles uninstalled'
