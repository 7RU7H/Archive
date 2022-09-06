# Linux-One-Liners-To-Rule-Them-All

Incoming watching of talk "One-Liners-To-Rule-Them-All"

## File System One-Liners

Make a new sub-directory putting all current directory into that new directory 
```bash
mkdir $new_subdirectory | ls | grep -v $new_subdirectory | tr -S '\n' ' ' | xargs -I@ bash -c 'mv @ $new_subdirectory/'
```


## References