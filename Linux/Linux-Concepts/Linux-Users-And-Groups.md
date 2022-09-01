# Linux Users and Groups

## User's `/home/<username>` directory

`~` is the symbol that can be invoked in a command to direct the command in a file the current users directory when that command is invoked from any location in the Linux file system
```bash
cat ~/.bash_history
```

- `~/Desktop/` will contain the graphical displayed contents of this directory (or whatever the appropriate translation is for systems not configured in English).

- Incoming emails into a `~/Mail/` directory.

Contains personal configuration files often referred to as *dotfiles*:
- `~/.*rc` files that application specific configuration files.
-`~/.ssh/` 


#### Potential Future Changes to this article
The [FreeDesktop.org](https://www.freedesktop.org/) umbrella has resulted in the XDG Base Directory Specification, a convention that aims at cleaning up these files and directories. This specification states that configuration files should be stored under `~/.config`, cache files under `~/.cache`, and application data files under `~/.local` (or subdirectories thereof). This convention is slowly gaining traction.