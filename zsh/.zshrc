ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$HOME/.zsh-custom"
ZSH_THEME="hachibu"

plugins=(git heroku redis-cli yarn)

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

# Aliases
alias gce="git config --edit --global"
alias rake="bundle exec rake"
alias rails="foreman run rails"
alias vimrc="vim $HOME/.vimrc"
alias wootric-services="svscan $HOME/Code/Wootric/services/wootric-services"
alias wootric-pull-requests="github-pull-requests wootric"
alias wootric-pull-requests-post="github-pull-requests wootric | text-wrap '\`\`\`' | slack-post-message development-discuss"
alias zshrc="vim $HOME/.zshrc"

# Functions
explain() {
  local cmd="$@"
  open "https://explainshell.com/explain?cmd=$cmd"
}

# Initializers
eval "$(rbenv init -)"
