# Red Linux

Website 
`Ctrl + Shift + R` - cache refresh pages to ensure last game does not misinform as to current context


Hide your shell, beware is easily counterable [ethicalhacker club article](https://ethicalhackers.club/hack-the-box-battlegrounds-cyber-mayhem-attack-defense-review-strategies-tips-and-tricks/) - [referenced](https://askubuntu.com/questions/859501/how-to-hide-all-command-output-with-zsh-and-bash/860230#860230)
```bash
# redirect stdout and stdin to null 
exec >/dev/null # restored with: `exec >/dev/tty`
```

Use Bash Globbing to clutter adversaries stdout on `ls` usage 
```bash
# ls on a directory with the below will produce the usage for ls
touch ./--help 
```

Linux File ACLs and Attributes - 
```bash
getfacls
chattr
lsattr
```

If you need to kill a specific process using a given port
```bash
ps aux | grep $app # or..
pgrep $app
sudo fuser -k 445/tcp
```

## References

[ethicalhacker club article](https://ethicalhackers.club/hack-the-box-battlegrounds-cyber-mayhem-attack-defense-review-strategies-tips-and-tricks/)
[haax.fr linux-systems/tricks/](https://cheatsheet.haax.fr/linux-systems/tricks/)