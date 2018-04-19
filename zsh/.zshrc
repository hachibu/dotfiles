ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="hachibu"

source $ZSH/oh-my-zsh.sh
source .secrets.zsh

# Path
PATH="/usr/bin:/bin:/usr/sbin:/sbin"

PATH="/usr/local/bin:$PATH"
for DIR in /usr/local/opt/*/bin; do
  if [[ -d $DIR ]]; then PATH="$DIR:$PATH"; fi
done

for DIR in $HOME/Code/scripts/*; do
  if [[ -d $DIR ]]; then PATH="$DIR:$PATH"; fi
done

PATH="/Applications/calibre.app/Contents/MacOS:$PATH"

# Aliases
alias vimrc="vim $HOME/.vimrc"
alias wootric-services="svscan $HOME/Code/Wootric/services"
alias wootric-services-slim="svscan $HOME/Code/Wootric/services-slim"
alias wootric-pull-requests="github-pull-requests wootric"
alias wootric-pull-requests-post="github-pull-requests wootric | text-wrap '\`\`\`' | slack-post-message development-discuss"
alias zsh-reload="source $HOME/.zshrc"
alias zshrc="vim $HOME/.zshrc"

# Functions
function explain-shell() {
  open "https://explainshell.com/explain?cmd=$1"
}

function truncate-zsh-history() {
  local HIST="$HOME/.zsh_history"
  local HIST_SIZE=100
  echo "$(tail -n $HIST_SIZE $HIST)" > "$HIST"
}

function growl() {
  echo "\e]9;$1\007"
}

preexec() {
  redis-cli incr "zsh-history:$1" > /dev/null
}

# Initializers
eval "$(rbenv init -)"
truncate-zsh-history
