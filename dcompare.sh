#!/bin/bash
# gh - 2022
# d compare
#######

outlog=./dcompare.log 

getorphan()
{
  cd /opt/broadpeak
  find $1 -type f | sed "s/$1/$2/g" | while read i ; do
    [[ -f $i ]] && : || {
        echo $i | sed "s/$2/$1/g" | tee -a $4
        [[ $# -eq 0 ]] && : || {
        [[ "$3" == "copy" ]] && { 
          echo -e "moving $i to $2...\n"
          cp $i $2 
        } || {
        [[ "$3" == "delete" ]] && {
          echo -e "removing $i...\n"
          sudo rm $i
        || : } 
        } 
        }
    }
  done
}

while read i ; do 
  case $i in
    -source*) source=$(echo $i | awk '{ print $2 }' ) ;;
    -target*) target=$(echo $i | awk '{ print $2 }') ;;
    --delete) action="delete" ;;
    --copy) action="copy" ;;
  esac
done < <(echo $* | sed 's/ \-/\n-/g' )

getorphan $source $target $action $outlog 
