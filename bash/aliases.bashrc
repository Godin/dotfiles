#!/bin/bash

if [[ -f /usr/bin/xclip ]]
then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
fi

alias cppwd='echo -n $PWD | pbcopy'
alias e='emacsclient --tty --alternate-editor=""'

# ls: use a long listing format, show human-readable sizes
alias ls='ls -lh --color=auto'

alias grep='grep --colour=auto'

if [[ "$OSTYPE" != "darwin"* ]]; then
  alias open=xdg-open
fi
