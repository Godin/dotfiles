#!/bin/zsh

mvnw() {
  local dir="$PWD"
  while [[ ! -x "$dir/mvnw" && "$dir" != "/" ]]; do
    dir="${dir:h}"
  done

  if [[ -x "$dir/mvnw" ]]; then
    "$dir/mvnw" "$@"
    return $?
  fi

  command mvn "$@"
}

alias mvn=mvnw
