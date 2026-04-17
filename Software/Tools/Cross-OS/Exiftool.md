# `exiftool`


**Warning `3 commands` of this article were created with `ChatGPT` and human consultation of `references previously` - 16 April version of free ChatGPT**

[Strip all metadata from a file](https://exiftool.org/forum/index.php?topic=10479.0)
```bash
exiftool -all= $file
# All *.jpg in current directory
exiftool -all= *.jpg
# Find all the *.png in a path and remove all metadata
find $path/ -type f -name "*.png" -exec exiftool -all= {} \; 2>/dev/null
# Quietly remove all the metadata from  all the *.png in a path 
find $path/ -type f -name "*.png" -exec exiftool -q -all= {} \; 2>/dev/null
```

 For safer more thorough version used Cha-cha geronemo
```bash
# Remove -P for if you have pictures in .hiddenDirectories ;)
find -P ~/ -type f -iname *.png 2>/dev/null | wc -lv
# All don't follow symlinks, if for some insane reason you need to follow symlinks `-H` and remove the `-xtype l`
find . -type f -name "*.png" -exec exiftool -overwrite_original -all= {} \; 2>/dev/null
find . -type f -name "*.png" -exec convert {} -strip {} \;
```


Check metadata
```
exiftool -xmp:author:all -a *
```

## References

[exiftool.org/forum - Strip all metadata from a file](https://exiftool.org/forum/index.php?topic=10479.0)