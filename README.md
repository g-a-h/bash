# bash-tools
a repository of miscellaneous bash scripts

# dupes.sh
find duplicates files or folders.<br>
 | arg | description |
 | --- | --- |
 | -d  | search path <br> (required)|
 | -t  | type <br> 'files' or 'folders' <br> (required)|
 | -v  | verbose output <br> (optional)|
 | --delete  | delete duplicate <br> (optional)|


```bash
$ bash dupes.sh -d /etc/usr/local -t folders -v --delete 
```
~ order of args does not matter 
```
$ bash dupes.sh -t files -d /var/ 
```

 # dcompare.sh
compare directory trees (source v. target) with ability to:
- copy files/folders if absent from target
- delete files/folders if absent from source
<br> 
useful for validating data migration (ie. migrating data from an old NAS to a new)
