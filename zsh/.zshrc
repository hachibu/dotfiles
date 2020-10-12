ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$HOME/.zsh-custom"
ZSH_THEME="hachibu"

plugins=(git heroku redis-cli yarn zsh_reload)

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

if [ -f '/Users/ray/Code/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ray/Code/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/ray/Code/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ray/Code/google-cloud-sdk/completion.zsh.inc'; fi

# Aliases
alias dc="docker-compose"
alias fs="bundle exec foreman start"
alias gc="git commit"
alias gc!="git commit --amend"
alias gas=" cat ~/.oh-my-zsh/plugins/git/git.plugin.zsh | grep alias | less"
alias gbd!="git branch -D"
alias gce="git config --edit --global"
alias gfp="gfa && gup"
alias gp!="gp -f"
alias gs="git show"
alias gsn="git show --name-only"
alias mock-cxi-csv="mock-csv feedback:quote feedback_date:time user_id:email"
alias rake="bundle exec rake"
alias rbenv-gcc="CC=/usr/bin/gcc rbenv"
alias rails="foreman run rails"
alias rspec="bundle exec rspec --color"
alias n="note.sh"
alias t="todo.sh"
alias tree="tree -a -C -I 'node_modules|target|.git|.vim'"
alias vimrc="vim $HOME/.vimrc"
alias ws="svscan $HOME/Code/Wootric/services/wootric-services"
alias wpr="github-pull-requests.rb Wootric"
alias wprp="github-pull-requests.rb Wootric | text-wrap '\`\`\`' | slack-post-message development-discuss"
alias zshrc="vim $HOME/.zshrc"

# Functions
function git-root() {
  while [ ! -d ".git" ]; do
    cd ..
  done
}

function truncate-history() {
  echo "$(tail -n 1000 $HISTFILE)" > $HISTFILE
}

function delete-postmaster-pid() {
  rm -rf "/usr/local/var/postgresql@9.6/postmaster.pid"
}

function reset-postgres() {
  rm -rf /usr/local/var/postgres
  initdb /usr/local/var/postgres -E utf8
}

function delete-ds-store() {
  find . -name '.DS_Store' -type f -delete
}

# Initializers
if [ -x "$(command -v rbenv)" ]; then
  eval "$(rbenv init -)"
fi

truncate-history

source /Users/$USER/Library/Preferences/org.dystroy.broot/launcher/bash/br
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
