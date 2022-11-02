#!/bin/bash
# gh - 2022
# nas.compare
#######

nas1=$1 
nas2=$2
action=$3
outlog=$4

getorphan()
{
  cd /opt/broadpeak
  find $1 -type f | sed "s/$1/$2/g" | while read i ; do
    [[ -f $i ]] && : || {
        echo $i | sed "s/$2/$1/g" | tee -a $4
        [[ $# -eq 0 ]] && : || {
        [[ "$3" == "-move" ]] && { 
          echo -e "moving $i to $2...\n"
          cp $i $2 
        } || {
        [[ "$3" == "-delete" ]] && {
          echo -e "removing $i...\n"
          sudo rm $i
        || : } 
        } 
        }
    }
  done
}

getorphan $nas1 $nas2 $action $outlog 
