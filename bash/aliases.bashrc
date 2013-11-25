#!/bin/bash

if $(xsel &>/dev/null)
then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
fi

alias cppwd='echo -n $PWD | pbcopy'

alias ls='ls --color=auto'
alias grep='grep --colour=auto'
