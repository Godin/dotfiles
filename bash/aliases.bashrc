#!/bin/bash

if [[ -f /usr/bin/xclip ]]
then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
fi

alias cppwd='echo -n $PWD | pbcopy'

alias ls='ls --color=auto'
alias grep='grep --colour=auto'
