# FreeBSD Directory Structure

Directory | Description
--- | ---
/ | Root directory of the file system.
/bin/ | User utilities fundamental to both single-user and multi-user environments.
/boot/ | Programs and configuration files used during operating system bootstrap.
/boot/defaults/ | Default bootstrapping configuration files; see loader.conf(5).
/dev/ | Device nodes; see intro(4).
/etc/ | System configuration files and scripts.
/etc/defaults/ | Default system configuration files; see rc(8).
/etc/mail/ | Configuration files for mail transport agents such as sendmail(8).
/etc/namedb/ | named configuration files; see named(8).
/etc/periodic/ | Scripts that are run daily, weekly, and monthly, via cron(8); see periodic(8).
/etc/ppp/ | ppp configuration files; see ppp(8).
/mnt/ | Empty directory commonly used by system administrators as a temporary mount point.
/proc/ | Process file system; see procfs(5), mount_procfs(8).
/rescue/ | Statically linked programs for emergency recovery; see rescue(8).
/root/ | Home directory for the root account.
/sbin/ | System programs and administration utilities fundamental to both single-user and multi-user environments.
/stand/ | Programs used in a standalone environment.
/tmp/ | Temporary files. The contents of /tmp are usually NOT preserved across a system reboot. A memory-based file system is often mounted at /tmp. This can be automated using the tmpmfs-related variables of rc.conf(5) (or with an entry in /etc/fstab; see mdmfs(8), or for FreeBSD 4.X, mfs(8)).
/usr/ | The majority of user utilities and applications.
/usr/bin/ | Common utilities, programming tools, and applications.
/usr/include/ | Standard C include files.
/usr/lib/ | Archive libraries.
/usr/libdata/ | Miscellaneous utility data files.
/usr/libexec/ | System daemons & system utilities (executed by other programs).
/usr/local/ | Local executables, libraries, etc. Also used as the default destination for the FreeBSD ports framework. Within /usr/local, the general layout sketched out by hier(7) for /usr should be used. Exceptions are the man directory, which is directly under /usr/local rather than under /usr/local/share, and the ports documentation is in share/doc/port.
/usr/obj/ | Architecture-specific target tree produced by building the /usr/src tree.
/usr/ports | The FreeBSD Ports Collection (optional).
/usr/sbin/ | System daemons & system utilities (executed by users).
/usr/share/ | Architecture-independent files.
/usr/src/ | BSD and/or local source files.
/usr/X11R6/ | X11R6 distribution executables, libraries, etc (optional).
/var/ | Multi-purpose log, temporary, transient, and spool files. A memory-based file system is sometimes mounted at /var. This can be automated using the varmfs-related variables of rc.conf(5) (or with an entry in /etc/fstab; see mdmfs(8), or for FreeBSD 4.X, mfs(8)).
/var/log/ | Miscellaneous system log files.
/var/mail/ | User mailbox files.
/var/spool/ | Miscellaneous printer and mail system spooling directories.
/var/tmp/ | Temporary files. The files are usually preserved across a system reboot, unless /var is a memory-based file system.
/var/yp | NIS maps.

## References

[docs.freebsd.org](https://docs.freebsd.org/doc/6.1-RELEASE/usr/share/doc/handbook/dirstructure.html)