#!/bin/bash

# Formatting constants
BOLD=`tput bold`
UNDERLINE_ON=`tput smul`
UNDERLINE_OFF=`tput rmul`
TEXT_BLACK=`tput setaf 0`
TEXT_RED=`tput setaf 1`
TEXT_GREEN=`tput setaf 2`
TEXT_YELLOW=`tput setaf 3`
TEXT_BLUE=`tput setaf 4`
TEXT_MAGENTA=`tput setaf 5`
TEXT_CYAN=`tput setaf 6`
TEXT_WHITE=`tput setaf 7`
BACKGROUND_BLACK=`tput setab 0`
BACKGROUND_RED=`tput setab 1`
BACKGROUND_GREEN=`tput setab 2`
BACKGROUND_YELLOW=`tput setab 3`
BACKGROUND_BLUE=`tput setab 4`
BACKGROUND_MAGENTA=`tput setab 5`
BACKGROUND_CYAN=`tput setab 6`
BACKGROUND_WHITE=`tput setab 7`
RESET_FORMATTING=`tput sgr0`

color_mvn() {
  if [[ ! -t 1 ]]; then
    # not terminal, so can not use colors
    command mvn "$@"
    return $?
  fi

  command mvn "${@}" 2>&1 | gawk -f $DOTFILES/maven/maven.awk

  # See comp.unix.shell FAQ "How do I get the exit code of cmd1 in cmd1|cmd2": http://cfajohnson.com/shell/cus-faq-2.html
  return ${PIPESTATUS[0]}
}

# Sometimes after interruption of Maven colorization by Ctrl-C, terminal might be in a broken state.
# I wasn't able to really understand why. So here is a workaround to avoid this.
# Should be noted that Midnight Commander overwrites PROMPT_COMMAND, but patch available - https://www.midnight-commander.org/ticket/2027
bash_prompt_command() {
  reset -I
}
PROMPT_COMMAND=bash_prompt_command

alias mvn=color_mvn
