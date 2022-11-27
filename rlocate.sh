#!/usr/local/env bash
# gh - 2022
# real locate

ls /* | xargs -n1000 -P1 -I % find % $1 2>/dev/null | grep $1
