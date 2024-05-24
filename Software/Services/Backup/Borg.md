# Borg 

> [Borg](https://borgbackup.readthedocs.io/en/stable/) *"BorgBackup (short: Borg) is a deduplicating backup program. Optionally, it supports compression and authenticated encryption. The main goal of Borg is to provide an efficient and secure way to backup data. The data deduplication technique used makes Borg suitable for daily backups since only changes are stored. The authenticated encryption technique makes it suitable for backups to not fully trusted targets. See the [installation manual](https://borgbackup.readthedocs.org/en/stable/installation.html) or, if you have already downloaded Borg, `docs/installation.rst` to get started with Borg. There is also an [offline documentation](https://readthedocs.org/projects/borgbackup/downloads) available, in multiple formats."

[borgbackup.readthedocs.io](https://borgbackup.readthedocs.io)

```bash
apt install borgbackup
```

Dirty extract the data you want from a Borg archive
```bash
# Get the name of archive to be extracted
borg list $ARCHIVE
# List the directory structure
borg extract --list $ARCHIVE::$name --stdout
# Extract a file to stdout to read 
borg extract $ARCHIVE::$path/file.txt --stdout
```
## References

[borgbackup.readthedocs.io](https://borgbackup.readthedocs.io)