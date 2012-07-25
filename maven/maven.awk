function colorize(str, color) {
  printf "%s%s\x1b[0m\n", color, str;
  next;
}
function red(str) {
  colorize(str, "\x1b[1;31m")
}
function green(str) {
  colorize(str, "\x1b[1;32m")
}
function yellow(str) {
  colorize(str, "\x1b[1;33m")
}
function blue(str) {
  colorize(str, "\x1b[1;34m")
}

match($0, /^/) {
  printf "%s ", strftime("%H:%M:%S");
}
match($0, /\[INFO\]\ \-\-\-\ /) { blue($0); }
match($0, /\[WARNING\]/) { yellow($0); }
match($0, /\[WARN\]/) { yellow($0); }
match($0, /\[ERROR\]/) { red($0); }
match($0, /(\[INFO\] .*)(SUCCESS .*)/, g) {
  printf "%s\x1b[1;32m%s\x1b[0m\n", g[1], g[2];
  next;
}
match($0, /\[INFO\] BUILD FAILURE/) { red($0); }
match($0, /\[INFO\] BUILD SUCCESS/) { green($0); }
match($0, /\[INFO\] .* FAILURE/) { red($0); }
match($0, /^Tests run: ([0-9]+), Failures: ([0-9]+), Errors: ([0-9]+), Skipped: ([0-9]+), (.*)$/, g) {
  printf "\x1b[1;32mTests run: %s\x1b[0m, Failures: \x1b[1;31m%s\x1b[0m, Errors: \x1b[1;31m%s\x1b[0m, Skipped: \x1b[1;33m%s\x1b[0m, %s\n", g[1], g[2], g[3], g[4], g[5];
  next;
}
match($0, /^.*$/) {
  printf "%s\n", $0;
}
