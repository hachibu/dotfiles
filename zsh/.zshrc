ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="lukerandall"
ZSH_DISABLE_COMPFIX="true"
EDITOR="vim"

plugins=(git)

source $ZSH/oh-my-zsh.sh

SECRETS_PATH="$HOME/.secrets.zsh"
if [ -f $SECRETS_PATH ]; then
  source $SECRETS_PATH
else
  touch $SECRETS_PATH
fi

if command -v go &> /dev/null; then
  GOPATH=$(go env GOPATH)
fi

# Path
PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

if [[ "$OSTYPE" == "darwin"* ]]; then
  PATH="/opt/homebrew/bin:$PATH"
fi

SCRIPTS_PATH="$HOME/Code/dotfiles/bin"
if [ -d $SCRIPTS_PATH ]; then
  for DIR in $SCRIPTS_PATH/*; do
    if [[ -d $DIR ]]; then PATH="$DIR:$PATH"; fi
  done
fi

# Initializers
if command -v rbenv &> /dev/null; then
  eval "$(rbenv init - zsh)"
fi
