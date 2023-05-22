_mvn() {
  _arguments -C \
    "(-f --file)"{-f,--file}'[force the use of an alternate POM file]:POM file:_mvn_pom_files' \
    "(-V --show-version)"{-V,--show-version}'[display version information without stopping build]' \
    "(-N --non-recursive)"{-N,--non-recursive}'[do not recurse into sub-projects]' \
    "*"{-D-,--define}'[define a system property]:property:_mvn_properties' \
    "*: :_mvn_args"
}

(( $+functions[_mvn_args] )) ||
_mvn_args() {
  _alternative \
    'phases:phase:_mvn_phases' \
    'plugins:plugin:_mvn_plugins'
}

(( $+functions[_mvn_plugins] )) ||
_mvn_plugins() {
  local plugins
  plugins=(
    'dependency\:tree'
    'versions\:display-plugin-updates'
    'versions\:display-dependency-updates'
    'versions\:display-parent-updates'
    'spotless\:apply'
  )
  _describe -t 'plugins' 'plugin' plugins
}

(( $+functions[_mvn_phases] )) ||
_mvn_phases() {
  local phases
  phases=(
    'clean:remove all files generated by the previous build'
    'compile:compile the source code of the project'
    'test:run tests using a suitable unit testing framework'
    'package:take the compiled code and package it in its distributable format, such as a JAR'
    'verify:run any checks to verify the package is valid and meets quality criteria'
    'install:install the package into the local repository, for use as a dependency in other projects locally'
  )
  _describe -t 'phases' "phase" phases
}

(( $+functions[_mvn_properties] )) ||
_mvn_properties() {
  local properties
  properties=(
    'skipTests'
    'spotless.check.skip'
  )
  _describe -t 'property' 'property' properties
}

(( $+functions[_mvn_pom_files] )) ||
_mvn_pom_files() {
  _files -g 'pom\.xml'
}

compdef _mvn mvn
