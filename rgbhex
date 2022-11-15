#!/usr/bin/env bash
# gh - 2022 
# hex/rbg convert 

erro() {
    echo  "no input received.."
}

gethex() {
    printf '#%02x%02x%02x\n' "$1" "$2" "$3"
}

getrgb() {
    : "${1/\#}"
    ((r=16#${_:0:2},g=16#${_:2:2},b=16#${_:4:2}))
    printf '%s\n' "$r $g $b"
}

[[ $# -eq 0 ]] && erro || {
  [[ "$1" -eq "hex" ]] && gethex $2 || {
    [[ "$2" -eq "rgb" ]] && getrgb $2 || {
	echo "unknown args.."
	}
    }
  }
