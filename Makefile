STOW_DIRS = git vim zsh

.PHONY: setup-linux
setup-linux:
	@bin/setup/setup-linux

.PHONY: setup-mac
setup-mac:
	@bin/setup/setup-mac

.PHONY: install
install:
	@stow -S stow -t ~
	@stow -S $(STOW_DIRS) -t ~
	@echo 'dotfiles installed: $(STOW_DIRS)'

.PHONY: uninstall
uninstall:
	@stow -D $(STOW_DIRS) -t ~
	@stow -D stow -t ~
	@echo 'dotfiles uninstalled: $(STOW_DIRS)'
