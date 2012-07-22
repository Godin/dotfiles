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
  command mvn "${@}" 2>&1 | gawk '{ print strftime("%H:%M:%S"), $0; fflush(); }' | sed \
    -e "s/\(\[INFO\]\ \-\-\-\ .*\)/${BOLD}${TEXT_BLUE}\1${RESET_FORMATTING}/g" \
    -e "s/\(\[INFO\]\ \[.*\)/${RESET_FORMATTING}${BOLD}\1${RESET_FORMATTING}/g" \
    -e "s/\(\[WARNING\].*\)/${BOLD}${TEXT_YELLOW}\1${RESET_FORMATTING}/g" \
    -e "s/\(\[ERROR\].*\)/${BOLD}${TEXT_RED}\1${RESET_FORMATTING}/g" \
    -e "s/\(\[INFO\]\ BUILD FAILURE\)/${BOLD}${TEXT_RED}\1${RESET_FORMATTING}/g" \
    -e "s/\(\[INFO\]\ BUILD SUCCESS\)/${BOLD}${TEXT_GREEN}\1${RESET_FORMATTING}/g" \
    -e "s/\(\[INFO\] .* FAILURE .*\)/${BOLD}${TEXT_RED}\1${RESET_FORMATTING}/g" \
    -e "s/\(\[INFO\] .*\)\(SUCCESS .*\)/\1${BOLD}${TEXT_GREEN}\2${RESET_FORMATTING}/g" \
    -e "s/Tests run: \([^,]*\), Failures: \([^,]*\), Errors: \([^,]*\), Skipped: \([^,]*\)/${BOLD}${TEXT_GREEN}Tests run: \1${RESET_FORMATTING}, Failures: ${BOLD}${TEXT_RED}\2${RESET_FORMATTING}, Errors: ${BOLD}${TEXT_RED}\3${RESET_FORMATTING}, Skipped: ${BOLD}${TEXT_YELLOW}\4${RESET_FORMATTING}/g"

  # See comp.unix.shell FAQ "How do I get the exit code of cmd1 in cmd1|cmd2": http://cfajohnson.com/shell/cus-faq-2.html
  return ${PIPESTATUS[0]}
}

alias mvn=color_mvn
