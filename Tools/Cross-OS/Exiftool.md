# Exiftool

[Strip all metadata from a file](https://exiftool.org/forum/index.php?topic=10479.0)
```bash
exiftool -all= $file
# All *.jpg in current directory
exiftool -all= *.jpg
```

Check metadata
```
exiftool -xmp:author:all -a *
```

## References

[exiftool.org/forum - Strip all metadata from a file](https://exiftool.org/forum/index.php?topic=10479.0)