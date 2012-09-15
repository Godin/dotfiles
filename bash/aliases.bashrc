#!/bin/bash

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

alias cppwd='echo -n $PWD | pbcopy'

alias mount='mount | column -t'
