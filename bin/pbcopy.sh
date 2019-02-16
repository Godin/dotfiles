#!/bin/sh

case `uname` in
  Darwin)
    pbcopy
  ;;
  Linux)
    xclip -selection clipboard -in
  ;;
esac
