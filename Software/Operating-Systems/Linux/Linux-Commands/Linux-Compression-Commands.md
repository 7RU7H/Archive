# Linux Compression Commands



## Just View in GUI 

```bash
engrampa $file
```

## Decompression

```bash
tar xvf $file.tar
tar xf $file.tar.gz
gzip -x $file.gz
# 7z 
7z e $file.7z # Extract
7z x $file.7z # Extract a file with full paths

# rar
# Sometimes a .rar file fails to be unrared with e flag 
unrar e $file.rar
```

Mass Decompression
```bash
# .zip
for i in $(ls -1 | grep '.zip'); do unzip $i; done
# .7z
for i in $(ls -1 | grep '.7z'); do 7z x $ip; wait; done
```

## Compression

7z add to an archive
```bash
7z a archive.7z $toArchiveDir
```

## Multi-file Archives

Multiarchive zip files 
```bash
# if the result `ls` would be  archive1.zip, archive2.zip and archive3.zip
# And require each combined to be a actual archive that can be decompressed
cat archive*.zip > combined.zip
unzip combined.zip
```

## References

[Github - cheat 7z](https://github.com/cheat/cheatsheets/blob/master/7z)