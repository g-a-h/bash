#!/usr/local/env bash 
# gh - 2022 
# genkeys bitcoin
#######
hexup() {
  tr "[a-f]" "[A-F]"
}

gen() { 
  openssl ecparam -genkey -name secp256k1 -noout | openssl ec -text 2>/dev/null \
  | grep -A3 priv | grep -v 'priv' | fmt -120 | sed 's/[: ]//g' |  awk '{printf "%064s\n", $0}' | hexup
} 

hashpub() { 
  echo $1 | openssl ec -pubout -outform DER 2>/dev/null | tail -c 65 \
  | openssl dgst -sha256 -binary | openssl dgst -rmd160 -binary | xxd -p -c 80 | hexup 
} 

chksum() {
  echo $1 | xxd -p -r | openssl dgst -sha256 -binary | openssl dgst -sha256 -binary | xxd -p -c 80 | head -c 8 | hexup
} 

base=($(echo {1..9} {A..Z} {a..z})) 
encode() { 
  echo $1 | sed -e 's/\(\(00\)*\).*/\1/' -e 's/00/1/g' | bc <<<"ibase=16; n=$1; while(n>0) { n%3A ; n/=3A }" | tail -r \
  | while read n
      do echo -n ${base[n+1]}
    done
}

hex2addr() { 
  encode "$2$1$(chksum "$2$1")"
}
#######
pkhex=$(gen) && echo -e "pubkey\t:\t$pkhex"
hash=$(hashpub $pk) && echo -e "hash\t:\t$hash"
addr=$(hex2addr $hash "00") && echo -e "address\t:\t$addr" 
wif=$(hex2addr $pkhex "80") && echo -e "wif\t:\t$wif"
