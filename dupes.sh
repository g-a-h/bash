
#!/bin/bash
# gh - 2022
# find dupl
#######

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

while read i ; do 
  case $i in
    -d*|--delete) where=$(echo $i | awk '{ print $2 }' ) ;;
    -t*) what=$(echo $i | awk '{ print $2 }') ;;
    -v) verbose="-v" ;;
    --delete) action="delete" ;;
    --copy) action="copy" ;;
  esac
done < <(echo $* | sed 's/ \-/\n-/g' )

run $where $what $verbose $action 
