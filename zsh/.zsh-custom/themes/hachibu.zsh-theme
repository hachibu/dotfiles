#!/usr/bin/env zsh

setopt prompt_subst

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' formats "$FX[bold]%r$FX[no-bold]/%S" "%s/%b" "%%u%c"
zstyle ':vcs_info:*:*' actionformats "$FX[bold]%r$FX[no-bold]/%S" "%s/%b" "%u%c (%a)"
zstyle ':vcs_info:*:*' nvcsformats "%~" "" ""

git_info() {
  vcs_info
  print -P "%F{8}$vcs_info_msg_1_%f "
  command git rev-parse --is-inside-work-tree &>/dev/null || return
  command git diff --quiet --ignore-submodules HEAD &>/dev/null
  if [ $? -eq 0 ]
  then
    echo "%F{green}✓%f"
  else
    echo "%F{red}☓%f"
  fi
}

prompt_directory() {
  if [ -d .git ]
  then
    echo $(git_info)
  else
    echo "%F{8}%d%f"
  fi
}

precmd() {
  PROMPT="
%F{blue}%n@%m%f $(prompt_directory)
%(?.%F{green}.%F{red})❯%f "
}
