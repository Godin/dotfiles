#!/bin/sh

function svn() {
    local SVN="`which svn`"
    if [[ ! -t 1 ]]; then
      # not terminal, so can not use colors for pager
      # pass as is
      ${SVN} "$@"
      return
    fi

    if [[ $1 == diff ]] ; then
      # colorize
      ${SVN} diff "${@:2}" | colordiff | less -R
    elif [[ $1 == st ]] ; then
      # colorize
      ${SVN} st --ignore-externals "${@:2}" | grep -v '^X' | sed -e 's/^\?.*$/\0/' -e 's/^!.*$/\0/' -e 's/^A.*$/\0/' -e 's/^M.*$/\0/' -e 's/^D.*$/\0/'

    elif [[ $1 == log ]] ; then
      ${SVN} log "${@:2}" | less

    elif [[ $1 == up ]] ; then
      local old_revision=`${SVN} info "${@:2}" | awk '/^Revision:/ {print $2}'`
      local first_update=$((${old_revision} + 1))
      ${SVN} up "${@:2}"
      local new_revision=`${SVN} info "${@:2}" | awk '/^Revision:/ {print $2}'`
      if [ ${new_revision} -gt ${old_revision} ]; then
        svn log -v -rHEAD:${first_update} "${@:2}"
      else
        echo "No changes."
      fi

    else
      # pass as is
      ${SVN} "$@"
    fi
}
