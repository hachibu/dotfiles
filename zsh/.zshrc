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
export PYTHONDONTWRITEBYTECODE=1
export LIBRARY_PATH="/usr/local/opt/openssl/lib"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export EDITOR="vim"
export NOTE_DIR="$HOME/Dropbox/Notes"
export TIMEWARRIORDB="$HOME/Dropbox/TimeWarrior"

# Path
PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

if [[ "$OSTYPE" == "darwin"* ]]; then
  PATH="/usr/local/bin:$PATH"
  for DIR in /usr/local/opt/*/bin; do
    if [[ -d $DIR ]]; then PATH="$DIR:$PATH"; fi
  done
fi

PATH="$HOME/Library/Python/3.7/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="/usr/local/go/bin:$PATH"
PATH="/Library/TeX/texbin/:$PATH"

SCRIPTS_PATH="$HOME/Code/dotfiles/scripts"
if [ -d $SCRIPTS_PATH ]; then
  for DIR in $SCRIPTS_PATH/*; do
    if [[ -d $DIR ]]; then PATH="$DIR:$PATH"; fi
  done
fi

# Aliases
alias gc="git commit"
alias gc!="git commit --amend"
alias gas=" cat ~/.oh-my-zsh/plugins/git/git.plugin.zsh | grep alias | less"
alias gbd!="git branch -D"
alias gce="git config --edit --global"
alias gfp="gfa && gup"
alias gp!="gp -f"
alias gs="git show"
alias gsn="git show --name-only"
alias n="note.sh"
alias t="todo.sh"
alias tree="tree -a -C -I 'node_modules|target|.git|.vim|.pytest_cache'"
alias vimrc="vim $HOME/.vimrc"
alias zshrc="vim $HOME/.zshrc"
alias fzf="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

# Functions
function git-root() {
  while [ ! -d ".git" ]; do
    cd ..
  done
}

function truncate-history() {
  echo "$(tail -n 1000 $HISTFILE)" > $HISTFILE
}

function delete-ds-store() {
  find . -name '.DS_Store' -type f -delete
}

function delete-node-modules() {
  find . -name 'node_modules' -type d -exec rm -rf '{}' \;
}

function sizeof-node-modules() {
  find . -name "node_modules" -type d -prune -print | xargs du -chs
}

# Initializers
if [ -x "$(command -v brew)" ]; then
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
fi
