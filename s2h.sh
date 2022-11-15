#!/usr/local/env bash
#!/usr/local/env bash
# gh - 2022
# str2hex

erro() {
    echo "no input received.."
}

[[ $# -eq 0 ]] && erro || {
    str=${1:-""}
    seq 0 $((${#str}-1))  \
    | while read i ; do
      char=${str:i:1}
      printf "%x" "'$char"
    done
}
