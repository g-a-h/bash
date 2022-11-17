#!/usr/local/env bash
# gh - 2022
# genkeybtc
#######
pk=$(openssl ecparam -genkey -name secp256k1 -noout)
pkd=$(openssl ec -text <<<$pk 2>/dev/null)

putup() {
  tr "[a-f]" "[A-F]"
}

calchex() { 
openssl ec -text <<<$1 2>/dev/null | grep -A3 priv | grep -v 'priv' \
| fmt -120 | sed -e 's/[: ]//g' -e 's/^00//' | awk '{printf "%064s\n", $0}' | putup
} 

base=($(echo {1..9} {A..Z} {a..z} | sed 's/[O|I|l]//g' | sed 's/  / /g'))
encode() {
  in=$(sed -e 's/\(\(00\)*\).*/\1/' -e 's/00/1/g' <<<$1) && echo -n $in
  bc <<<"ibase=16; n=$1; while(n>0) { n%3A ; n/=3A }" | tail -r \
  | while read n
      do echo -n ${base[n+1]}
    done
}

hex2() {
  encode "$2$1$(xxd -p -r <<<"$2$1" | openssl dgst -sha256 -binary | openssl dgst -sha256 -binary \
  | xxd -p -c 80 | head -c 8 | putup)"
}

hash=$(openssl ec -pubout -outform DER <<<$pk 2>/dev/null | tail -c 65 | openssl dgst -sha256 -binary | openssl dgst -rmd160 -binary | xxd -p -c 80 | putup) && echo -e "hash\t:\t$hash"
pkhex=$(calchex $pkd) && echo -e "pubkey\t:\t$pkhex" 
addr=$(hex2 $hash "00") && echo -e "address\t:\t$addr"
wif=$(hex2 $pkhex "80") && echo -e "wif\t:\t$wif"
