
#!/bin/bash
# gh - 2022
# find dupl
#######

where=$1 
what=$2 
verbose=$3

run() {
[[ "$2" -eq "folders" ]] && type="d" || type="f"
find $1 -mindepth 1 -type $type  \
| while read i ; do
  [[ "$3" != "-v" ]] &&  : || echo $i 
  dupe=$(echo $i | tr "/" "\n"  | uniq -d | wc -l)
  [[ "$dupe" -gt "0" ]] && {
    echo -e "duplicate $2: $i" | tee -a dupes.log
  }
  done
}

run $where $what $verbose
