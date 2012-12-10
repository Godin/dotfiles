#!/bin/sh

BINDIR=$DOTFILES"/slices-of-life"

if crontab -l | grep -q "$BINDIR"
then
    echo "Already installed."
else
    echo -e "`crontab -l`\n# slices-of-life\n0,30 * * * * $BINDIR/slice-of-life.sh >/dev/null 2>&1" | crontab -
    echo "Intsalled."
fi
