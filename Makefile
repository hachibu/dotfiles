STOW_DIRS = git vim zsh

setup-linux:
	@bin/setup/setup-linux

setup-mac:
	@bin/setup/setup-mac

dotfiles-install:
	@stow -S stow -t ~
	@stow -S $(STOW_DIRS) -t ~
	@echo 'dotfiles installed: $(STOW_DIRS)'

dotfiles-uninstall:
	@stow -D $(STOW_DIRS) -t ~
	@stow -D stow -t ~
	@echo 'dotfiles uninstalled: $(STOW_DIRS)'
