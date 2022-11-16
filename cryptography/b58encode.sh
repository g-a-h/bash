#!/usr/local/env bash 
# gh - 2022 
# base58 

b58=$(echo {1..9} {A..Z} {a..z}) 

b58encode() { 
    echo -n $(sed -e 's/\(\(00\)*\).*/\1/' -e 's/00/1/g' <<<$1)
    bc <<<"ibase=16; n=$1; while(n>0) { n%3A ; n/=3A }" |
    tail -r | while read n
        do echo -n ${base58[n+1]}
     done
}

b5encode $1 
