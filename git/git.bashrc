#!/bin/bash

function __dotfiles_workdir() {
  local g="$(git rev-parse --git-dir 2>/dev/null)"
  if [ -n "$g" ]; then
    # current working directory in repository
    local subdir=$(git rev-parse --show-prefix 2>/dev/null)
    subdir="${subdir%/}"
    local workdir="${PWD%/$subdir}"
    printf "%s" "${workdir/*\/}${subdir:+/$subdir}"
  else
    # current working directory, with $HOME abbreviated with a tilde
    printf "%s" $(echo $PWD | sed -e "s#^$HOME#~#g")
  fi
}

GIT_PS1_SHOWUPSTREAM="verbose"
#GIT_PS1_SHOWDIRTYSTATE=true
PS1='\t \[\e[1;34m\]$(__dotfiles_workdir) \[\e[0\]m$(__git_ps1 "[%s] ")\[\e[1;34m\]\$ \[\e[0m\]'
