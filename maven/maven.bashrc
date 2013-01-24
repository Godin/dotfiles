#!/bin/bash

color_mvn() {
  if [[ ! -t 1 ]]; then
    # not terminal, so can not use colors
    command mvn "$@"
    return $?
  fi

  # Creation of new shell is required in order to not leave terminal in broken state after termination by Ctrl-C
  (
    command mvn "${@}" 2>&1 | gawk -f $DOTFILES/maven/maven.awk ;
    # See comp.unix.shell FAQ "How do I get the exit code of cmd1 in cmd1|cmd2": http://cfajohnson.com/shell/cus-faq-2.html
    exit ${PIPESTATUS[0]}
  )

  return $?
}

alias mvn=color_mvn
