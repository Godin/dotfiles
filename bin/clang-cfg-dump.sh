#/bin/sh

clang -fsyntax-only -Xclang -analyze -Xclang -analyzer-checker=debug.DumpCFG $*
