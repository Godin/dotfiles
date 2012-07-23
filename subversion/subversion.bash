#!/bin/bash

function svn() {
    if [[ ! -t 1 ]]; then
      # not terminal, so can not use colors for pager
      # pass as is
      command svn "$@"
      return
    fi

    if [ $# -lt 1 ]; then
      # no sub-command
      command svn
      return
    fi
    local sub_cmd=$1
    shift

    if [[ $sub_cmd == diff ]] ; then
      # colorize
      command svn diff "$@" | colordiff | less -RXF

    elif [[ $sub_cmd == st ]] ; then
      # colorize
      command svn st --ignore-externals "$@" | grep -v '^X' | sed -e 's/^\?.*$/\0/' -e 's/^!.*$/\x1b[31m\0\x1b[0m/' -e 's/^A.*$/\x1b[32m\0\x1b[0m/' -e 's/^M.*$/\x1b[33m\0\x1b[0m/' -e 's/^D.*$/\x1b[31m\0\x1b[0m/'

    elif [[ $sub_cmd == log ]] ; then
      command svn log "$@" | sed -e 's/^--*/\x1b[0;34m\0\x1b[0m/' -e 's/^\([^|]*\) | \(.*\)/\x1b[0;32m\1\x1b[0m | \2/' | less -RXF

    elif [[ $sub_cmd == up ]] ; then
      local old_revision=`command svn info "$@" | awk '/^Revision:/ {print $2}'`
      local first_update=$((${old_revision} + 1))
      command svn up "$@"
      local new_revision=`command svn info "$@" | awk '/^Revision:/ {print $2}'`
      if [ ${new_revision} -gt ${old_revision} ]; then
        svn log -v -rHEAD:${first_update} "$@"
      else
        echo "No changes."
      fi

    else
      # pass as is
      command svn $sub_cmd "$@"
    fi
}
