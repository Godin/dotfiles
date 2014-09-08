#/bin/sh

clang -fsyntax-only -Xclang -ast-dump $*
