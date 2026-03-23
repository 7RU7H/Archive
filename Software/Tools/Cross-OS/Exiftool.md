# `exiftool`

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

Check metadata
```
exiftool -xmp:author:all -a *
```

## References

[exiftool.org/forum - Strip all metadata from a file](https://exiftool.org/forum/index.php?topic=10479.0)