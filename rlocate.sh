#!/usr/bin/env bash
# gh - 2022
# real locate

find / -maxdepth 2 | tee .tre | xargs -n$(wc -l .tre) -P100 -I % find % $1 2>&1 | grep $1
