#!/bin/sh

if test ! $(which brew)
then
    echo "You should probably install Homebrew first:"
    echo "https://github.com/mxcl/homebrew/wiki/installation"
    exit
fi

brew install coreutils

brew install bash
