#!/bin/zsh

gradlew() {
  local dir="$PWD"
  while [[ ! -x "$dir/gradlew" && "$dir" != "/" ]]; do
    dir="${dir:h}"
  done

  if [[ -x "$dir/gradlew" ]]; then
    "$dir/gradlew" "$@"
    return $?
  fi

  command gradle "$@"
}

alias gradle=gradlew
