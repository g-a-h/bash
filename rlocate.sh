#!/usr/bin/env bash
# gh - 2022
# real locate

ls /* | xargs -n1000 -P100 -I % find % $1 2>&1 | grep $1
