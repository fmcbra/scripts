#!/bin/bash

# Ensure /com/scripts/{,s}bin is in PATH
[[ ${PATH/\/com/scripts\/bin/} == $PATH ]] \
  && export PATH="/com/scripts/bin:/com/scripts/sbin:$PATH"

for f in /var/lib/bootstrap.env
do
  [[ -e $f ]] || continue
  source $f
done

## vim: ts=2 sw=2 et fdm=marker :
