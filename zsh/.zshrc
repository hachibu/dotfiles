ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
EDITOR="vim"
plugins=(git)

source $ZSH/oh-my-zsh.sh
source $HOME/.secrets
source $HOME/.kubectl-completions.sh

alias k=kubectl
complete -o default -F __start_kubectl k
alias d=docker
alias t=terraform

# Path
if [[ "$OSTYPE" == "darwin"* ]]; then
  PATH="/opt/homebrew/bin:$PATH"
fi

# if command -v cargo &> /dev/null; then
#   PATH="$HOME/.cargo/bin:$PATH"
# fi

# if command -v deno &> /dev/null; then
#   PATH="$HOME/.deno/bin:$PATH"
# fi

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

# Initializers
#
# if command -v rbenv &> /dev/null; then
#   eval "$(rbenv init - zsh)"
# fi

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# export PYENV_ROOT="$HOME/.pyenv"

# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

# eval "$(pyenv init -)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/raymond-sohn/.lmstudio/bin"
# End of LM Studio CLI section

