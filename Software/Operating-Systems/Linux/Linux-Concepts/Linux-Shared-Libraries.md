# Linux Shared Libraries

Analysing `$file.so` 
```bash
# ldd
ldd $FILE
# objdump
objdump -p $FILE | grep 'NEEDED'
# readelf
readelf --dynamic $FILE | grep NEEDED

# find the pid and checking /proc maps file
pgrep $target
cat /proc/$PID/maps 
awk '$NF!~/\.so/{next} {$0=$NF} !a[$0]++' /proc/$PID/maps 
```

## References

[baeldung - show-shared-libraries-executables](https://www.baeldung.com/linux/show-shared-libraries-executables)