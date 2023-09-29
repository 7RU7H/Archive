# RunasCs

[RunasCs](https://github.com/antonioCoco/RunasCs) *is a utility to run specific processes with different permissions than the user's current logon provides using explicit credentials. This tool is an improved and open version of windows builtin runas.exe that solves some limitations:*
- *Allows explicit credentials*
- *Works both if spawned from interactive process and from service process*
- *Manage properly DACL for Window Stations and Desktop for the creation of the new process*
- *Uses more reliable create process functions like `CreateProcessAsUser()` and `CreateProcessWithTokenW()` if the calling process holds the required privileges (automatic detection)*
- *Allows to specify the logon type, e.g. 8-NetworkCleartext logon (no _UAC_ limitations)*
- *Allows to bypass UAC when an administrator password is known (flag --bypass-uac)*
- *Allows to create a process with the main thread impersonating the requested user (flag --remote-impersonation)*
- *Allows redirecting _stdin_, _stdout_ and _stderr_ to a remote host*
- *It's Open Source :)*

## References

[Github - RunasCs](https://github.com/antonioCoco/RunasCs)