#!/usr/bin/env python3

import os

path = os.environ['PATH'].split(':')
seen = {}
i = 0

while i < len(path):
  p = path[i]
  if p not in seen:
    seen[p] = True
  else:
    path.pop(i)
  i += 1

print(':'.join(path))

##
# vim: ts=2 sw=2 et fdm=marker fileencoding=utf-8 :
##
