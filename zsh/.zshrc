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
export LIBRARY_PATH=/usr/local/opt/openssl/lib

# Path
PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

if [[ "$OSTYPE" == "darwin"* ]]; then
  PATH="/usr/local/bin:$PATH"
  for DIR in /usr/local/opt/*/bin; do
    if [[ -d $DIR ]]; then PATH="$DIR:$PATH"; fi
  done
fi

SCRIPTS_PATH="$HOME/Code/dotfiles/scripts"
if [ -d $SCRIPTS_PATH ]; then
  for DIR in $SCRIPTS_PATH/*; do
    if [[ -d $DIR ]]; then PATH="$DIR:$PATH"; fi
  done
fi

# Aliases
alias mock-cxi-csv="mock-csv feedback:quote feedback_date:time user_id:email"
alias gc="git commit"
alias gc!="git commit --amend"
alias gas=" cat ~/.oh-my-zsh/plugins/git/git.plugin.zsh | grep alias | less"
alias gbd!="git branch -D"
alias gce="git config --edit --global"
alias gfp="gfa && gup"
alias gp!="gp -f"
alias rake="bundle exec rake"
alias rbenv-gcc="CC=/usr/bin/gcc rbenv"
alias rails="foreman run rails"
alias rspec="bundle exec rspec --color"
alias tree="tree -a -C -I 'node_modules|target|.git|.vim'"
alias vimrc="vim $HOME/.vimrc"
alias ws="svscan $HOME/Code/Wootric/services/wootric-services"
alias wpr="github-pull-requests wootric"
alias wprp="github-pull-requests wootric | text-wrap '\`\`\`' | slack-post-message development-discuss"
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

# Initializers
if [ -x "$(command -v rbenv)" ]; then
  eval "$(rbenv init -)"
fi

truncate-history
