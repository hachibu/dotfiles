# ZSH
ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh
source $HOME/.secrets

EDITOR="vim"

if command -v go &> /dev/null; then
  GOPATH=$(go env GOPATH)
fi

# Path
if [[ "$OSTYPE" == "darwin"* ]]; then
  PATH="/opt/homebrew/bin:$PATH"
fi

if command -v cargo &> /dev/null; then
  PATH="/$HOME/.cargo/bin:$PATH"
fi

DOTFILES_BIN_PATH="$HOME/Code/dotfiles/bin"
if [ -d $DOTFILES_BIN_PATH ]; then
  for DIR in $DOTFILES_BIN_PATH/*; do
    if [[ -d $DIR ]]; then PATH="$DIR:$PATH"; fi
  done
fi

# Initializers
if command -v rbenv &> /dev/null; then
  eval "$(rbenv init - zsh)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
