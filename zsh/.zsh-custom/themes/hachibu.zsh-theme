#!/usr/bin/env zsh

setopt prompt_subst

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' formats "$FX[bold]%r$FX[no-bold]/%S" "%s/%b" "%%u%c"
zstyle ':vcs_info:*:*' actionformats "$FX[bold]%r$FX[no-bold]/%S" "%s/%b" "%u%c (%a)"
zstyle ':vcs_info:*:*' nvcsformats "%~" "" ""

git_dirty() {
  command git rev-parse --is-inside-work-tree &>/dev/null || return
  command git diff --quiet --ignore-submodules HEAD &>/dev/null
  if [ $? -eq 0 ]
  then
    echo "%F{green}*%f"
  else
    echo "%F{red}*%f"
  fi
}

precmd() {
  echo
  if [ -d .git ]
  then
    vcs_info
    print -P "%F{8}$vcs_info_msg_1_`git_dirty` $vcs_info_msg_2_%f"
  fi
}

PROMPT="%F{blue}%n@%m%f %F{8}%d%f
%(?.%F{green}.%F{red})❯%f "
