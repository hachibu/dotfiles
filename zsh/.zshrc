# ZSH
ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="lukerandall"
ZSH_DISABLE_COMPFIX="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

EDITOR="vim"

if command -v go &> /dev/null; then
  GOPATH=$(go env GOPATH)
fi

# Path
if [[ "$OSTYPE" == "darwin"* ]]; then
  PATH="/opt/homebrew/bin:$PATH"
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
