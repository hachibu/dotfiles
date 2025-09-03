ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
EDITOR="vim"
plugins=(git)

source $ZSH/oh-my-zsh.sh
source $HOME/.secrets
source $HOME/.kubectl-completions.sh

# Aliases
alias k=kubectl
alias d=docker
alias t=terraform

complete -o default -F __start_kubectl k

# Path
if [[ "$OSTYPE" == "darwin"* ]]; then
  PATH="/opt/homebrew/bin:$PATH"
fi

if command -v go &> /dev/null; then
  GOPATH=$(go env GOPATH)
  PATH="$GOPATH/bin:$PATH"
fi

DOTFILES_BIN_PATH="$HOME/Code/dotfiles/bin"
if [ -d $DOTFILES_BIN_PATH ]; then
  for DIR in $DOTFILES_BIN_PATH/*; do
    if [[ -d $DIR ]]; then PATH="$DIR:$PATH"; fi
  done
fi
