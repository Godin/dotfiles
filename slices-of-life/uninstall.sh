#!/bin/sh

crontab -l | awk '$0!~/slices-of-life/ { print $0 }' | crontab -
