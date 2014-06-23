#/bin/sh

clang -cc1 -fcolor-diagnostics -analyze -analyzer-checker=debug.DumpCFG $*
