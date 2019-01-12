#!/bin/bash

# Make sure $SCRIPT_NAME is set appropriately
SCRIPT_NAME="${0##*/}"

function error()
{
  echo >&2 "$SCRIPT_NAME: error:" "$@"
}

function die()
{
  error "$@"
  exit 1
}

## {{{ function opt_arg()
function opt_arg()
{
  [[ $# -lt 2 ]] && die "function opt_arg() requires at least 3 args (got $#)"

  local opt="$1"; shift
  local arg="$1"; shift

  # --foo=bar
  arg="${arg#$opt=}"
  echo -n "$arg"

  return 0
}
## }}}

##
# vim: ts=2 sw=2 et fdm=marker :
##
