# Linux Compression Commands

## Just View 

```bash
engrampa $file
```

## Decompression

```bash
tar xvf $file.tar
tar xf $file.tar.gz
gzip -x $file.gz
7z e $file.7z
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
```
7z a 
```