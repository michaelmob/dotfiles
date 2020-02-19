#!/usr/bin/env python3
import code
from math import *
from pprint import pprint
from subprocess import check_output

p = pprint
_99 = 13034431
exit = None

def sh(cmd):
  return check_output(cmd, shell=True).decode("utf-8")

while True:
  code.interact(banner="", local=dict(globals(), **locals()))
