export JAVA_HOME="${HOME}/.java-select/current"
export JDK_HOME="${JAVA_HOME}"
export JAVAC="${JAVA_HOME}/bin/javac"
export PATH="${JAVA_HOME}/bin:${DOTFILES}/java-select/bin:${PATH}"

_java_select() {
  local completions
  completions="$(java-select --completion)"
  reply=("${(ps:\n:)completions}")
}

compctl -K _java_select java-select
