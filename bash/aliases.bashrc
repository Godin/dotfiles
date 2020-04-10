#!/bin/bash

if [[ -f /usr/bin/xclip ]]
then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
fi

alias cppwd='echo -n $PWD | pbcopy'
alias e='emacsclient --tty --alternate-editor=""'

# ls: use a long listing format, show human-readable sizes
alias ls='ls -lh --color=auto --group-directories-first'

alias grep='grep --colour=auto'

alias diff='git diff --no-index'

if [[ "$OSTYPE" != "darwin"* ]]; then
  alias open=xdg-open
fi
