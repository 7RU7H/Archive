# Linux-One-Liners-To-Rule-Them-All

Incoming watching of talk "One-Liners-To-Rule-Them-All"

## File System One-Liners

Make a new sub-directory putting all current directory into that new directory 
```bash
mkdir $new_subdirectory | ls | grep -v $new_subdirectory | tr -S '\n' ' ' | xargs -I@ bash -c 'mv @ $new_subdirectory/'
```

Find all the .nmap  files with open unique (no duplicates) confirmed (non 'service?') tcp services on open ports, sorted alphabetally f
```bash
find . -type f -name *.nmap -exec cat {} + | grep "/tcp" | sort -u | awk '{print $3}' | sort -u | grep -v '?\|[0-9]'
```


## String One-Line

Print all but the first field with awk
```bash
awk '{for (i=2; i<=NF; i++) printf $i " "; print $NF}'
```

## References