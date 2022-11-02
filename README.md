# bash-tools
a repository of miscellaneous bash scripts

# dupes
find duplicates files or folders.<br>
 | arg | description |
 | --- | --- |
 | -d  | search path <br> (required)|
 | -t  | type <br> 'files' or 'folders' <br> (required)|
 | -v  | verbose log <br> (optional)|
 | --delete  | delete duplicate <br> (optional)|

```bash
$ bash dupes.sh -d /etc/usr/local -t folders -v --delete 
$ bash dupes.sh -d /var/ -t files 
```
 
 # nascompare
 created to compare directory trees of two different nas storage (which should be identical) following a data migration 
 
