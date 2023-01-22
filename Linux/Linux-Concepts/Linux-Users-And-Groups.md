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

## Groups

From [Debian System groups](https://wiki.debian.org/SystemGroups)
-   **lp** (LP): Members of this group can enable and use printers. (The user **lp** is not used anymore.)
-   **lpadmin** (LPADMIN): Allows members to manage printers and pending jobs sent by other users.
-   **scanner** : Members of this group can enable and use scanners.
-   **adm**: Group adm is used for system monitoring tasks. Members of this group can read many log files in /var/log, and can use xconsole. Historically, /var/log was /usr/adm (and later /var/adm), thus the name of the group.    
-   **systemd-journal**: Since Debian 8 (Jessie), members of this group can use the command _journalctl_ and read log files of systemd (in /var/log/journal).   
-   **plugdev**: Allows members to mount (only with the options nodev and nosuid, for security reasons) and umount removable devices through pmount.   
-   **netdev**: Members of this group can manage network interfaces through the network manager and wicd.    
-   **cdrom**: This group can be used locally to give a set of users access to a CDROM drive and other optical drives.    
-   **floppy**: This group can be used locally to give a set of users access to a floppy drive and other removable (non-optical) drives (like USB flash drives). Starting with Debian 8 (Jessie) it is not used anymore for USB and flash memories.    
-   **tape**: This group can be used locally to give a set of users access to a tape drive.
-   **audio**: This group can be used locally to give a set of users access to an audio device (the soundcard or a microphone).    
-   **video**: This group can be used locally to give a set of users access to a video device (like a webcam).    
-   **render**: This group can be used locally to give a set of users access to a rendering device (like the framebuffer, or videocard).    
-   **sudo**: Members of this group can execute any command with sudo or pkexec. (See the default configuration in /etc/sudoers)    
-   **tty**: TTY devices are owned by this group. This is used by write and wall to enable them to write to other people's TTYs, but it is not intended to be used directly.
-   **staff**: Allows users to add local modifications to the system (/usr/local) without needing root privileges (note that executables in /usr/local/bin are in the PATH variable of any user, and they may "override" the executables in /bin and /usr/bin with the same name). Compare with group "adm", which is more related to monitoring/security.
-   **shadow**: /etc/shadow is readable by this group. Some programs that need to be able to access the file are SETGID shadow.
-   **utmp**: This group can write to /var/run/utmp and similar files. Programs that need to be able to write to it are SETGID utmp.
-   **disk**: Raw access to disks. **Mostly e quivalent to root access.**
-   **kmem**: /dev/mem and /dev/port are readable by this group. This is mostly a BSD relic, but any programs that need direct read access to the system's memory can thus be made SETGID kmem. /dev/kmem, that has given the name to this group, was also readable by this group, but is currently disabled by default for security reasons.
-   **dialout**: Full and direct access to serial ports. Members of this group can reconfigure the modem, dial anywhere, etc.
-   **dip**: The group's name stands for "Dial-up IP", and membership in dip allows you to use tools like ppp, dip, wvdial, etc. to dial up a connection. The users in this group cannot configure the modem, but may run the programs that make use of it.
-   **fax**: Allows members to use fax software to send / receive faxes.
-   **voice**: Voicemail, useful for systems that use modems as answering machines.
-   **users**: While Debian systems use the private user group system by default (each user has their own group), some prefer to use a more traditional group system, in which each user is a member of this group.
-   **wheel**: This group can be created to alter the functionality of the module pam_wheel in /etc/pam.d/su to restrict the execution of su. If this group does not exists only members of **root** (usually root itself) are affected. By default this group does not exist and all the configurations with pam_wheel are commented in /etc/pam.d/su. See the page about the [wheel_pam](https://wiki.debian.org/WHEEL/PAM) module for more information.
-   **src**: This group was used to manage the source code of the system, including files in /usr/src. It is not used anymore.
-   **bluetooth**: Users in this group can talk with bluetooth service via dbus, as defined in /etc/dbus-1/system.d/bluetooth.conf.
-   **libvirt**: Users in this group can talk with libvirt service via dbus, as defined in /etc/libvirt/libvirtd.conf.
-   **kvm**: Users in this group can use the KVM acceleration of virtual machines.


## References

[Debian System groups](https://wiki.debian.org/SystemGroups)