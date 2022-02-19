ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$HOME/.zsh-custom"
ZSH_THEME="hachibu"
ZSH_DISABLE_COMPFIX="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

SECRETS_PATH="$HOME/.secrets.zsh"
if [ -f $SECRETS_PATH ]; then
  source $SECRETS_PATH
else
  touch $SECRETS_PATH
fi

# Exports
export LIBRARY_PATH="/usr/local/opt/openssl/lib"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export EDITOR="vim"

# Path
PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

if [[ "$OSTYPE" == "darwin"* ]]; then
  PATH="/opt/homebrew/bin:$PATH"
fi

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$(go env GOPATH)

SCRIPTS_PATH="$HOME/Code/dotfiles/scripts"
if [ -d $SCRIPTS_PATH ]; then
  for DIR in $SCRIPTS_PATH/*; do
    if [[ -d $DIR ]]; then PATH="$DIR:$PATH"; fi
  done
fi

# Aliases
alias gc="git commit"
alias gc!="git commit --amend"
alias gbd!="git branch -D"
alias gfp="gfa && gup"
alias gp!="gp -f"
alias localstack="python3 -m localstack.cli.main"

# Functions
function git-root() {
  while [ ! -d ".git" ]; do
    cd ..
  done
}
