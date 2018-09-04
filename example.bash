#!/bin/bash

readonly LIB_PATH="$(cd $(dirname "$0")/..; pwd)/lib"
source "$LIB_PATH"/functions.bash || exit 1

exit 0

##
# vim: ts=2 sw=2 et fdm=marker :
##
