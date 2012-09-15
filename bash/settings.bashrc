#!/bin/bash

shopt -s no_empty_cmd_completion

# Remove duplicates from history
HISTCONTROL="ignoreboth"

# Size of history
HISTFILESIZE=3000

# Protection from Ctrl-D (exits from Bash)
IGNOREEOF=1
