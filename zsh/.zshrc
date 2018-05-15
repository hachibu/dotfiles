ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$HOME/.zsh-custom"
ZSH_THEME="hachibu"

plugins=(heroku redis-cli yarn)

source $ZSH/oh-my-zsh.sh
source /usr/local/etc/profile.d/z.sh

SECRETS_PATH="$HOME/.secrets.zsh"
if [ -f $SECRETS_PATH ]; then
  source $SECRETS_PATH
else
  touch $SECRETS_PATH
fi

# Path
PATH="/usr/bin:/bin:/usr/sbin:/sbin"

PATH="/usr/local/bin:$PATH"
for DIR in /usr/local/opt/*/bin; do
  if [[ -d $DIR ]]; then PATH="$DIR:$PATH"; fi
done

SCRIPTS_PATH="$HOME/Code/scripts"
if [ -d $SCRIPTS_PATH ]; then
  for DIR in $SCRIPTS_PATH/*; do
    if [[ -d $DIR ]]; then PATH="$DIR:$PATH"; fi
  done
fi

PATH="/Applications/calibre.app/Contents/MacOS:$PATH"

# Aliases
alias v="vim"
alias vimrc="vim $HOME/.vimrc"
alias wootric-services="svscan $HOME/Code/Wootric/services/wootric-services"
alias wootric-services-all="svscan $HOME/Code/Wootric/services/wootric-services-all"
alias wootric-pull-requests="github-pull-requests wootric"
alias wootric-pull-requests-post="github-pull-requests wootric | text-wrap '\`\`\`' | slack-post-message development-discuss"
alias zsh-reload="source $HOME/.zshrc"
alias zshrc="vim $HOME/.zshrc"

# Functions
function explain() {
  local cmd="$@"
  open "https://explainshell.com/explain?cmd=$cmd"
}

preexec() {
  redis-cli incr "zsh-history:$1" > /dev/null
}

# Initializers
eval "$(rbenv init -)"
