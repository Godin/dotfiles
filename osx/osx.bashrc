#!/bin/bash

if [[ -f /usr/local/bin/brew ]]
then
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
    export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
fi

# Remove all .DS_Store files from directory recursively
alias dsstore-clean='find . -type f -name .DS_Store -delete'
