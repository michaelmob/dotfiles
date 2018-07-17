#!/usr/bin/env bash
pamixer $@
pkill -RTMIN+1 i3blocks
