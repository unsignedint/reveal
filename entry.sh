#!/bin/bash
set -e

sub_build() {
  docker build --rm -t reveal-app .
}

sub_run() {
  docker run --rm -p 8080:8080 -it reveal-app
}

sub_help() {
  echo "Usage: $program <command> [options]"
  echo ""
  echo "Commands:"
  echo "    build       compile application container"
  echo "    run         run test container, listening on port 8080"
  echo ""
}


function_exists() {
  declare -f -F $1 > /dev/null
  return $?
}

program=$(basename $0)
command=$1
case $command in
"" | "-h" | "--help")
  sub_help
  ;;
*)
  shift
  if ! function_exists sub_${command}; then
    echo "Error: '$command' is not a known subcommand." >&2
    echo "       Run '$program --help' for a list of known subcommands." >&2
    exit 1
  fi
  sub_${command} $@
  ;;
esac

