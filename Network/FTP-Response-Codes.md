
## FTP Response Codes

**Code** | **Response**
--- | ---
100 Series  | The requested action is being initiated, expect another reply before proceeding with a new command.
110  | Restart marker replay . In this case, the text is exact and not left to the particular implementation; it must read: MARK yyyy = mmmm where yyyy is User-process data stream marker, and mmmm server's equivalent marker (note the spaces between markers and "=").
120  | Service ready in nnn minutes.
125  | Data connection already open; transfer starting.
150  | File status okay; about to open data connection.
200 Series  | The requested action has been successfully completed.
202  | Command not implemented, superfluous at this site.
211  | System status, or system help reply.
212  | Directory status.
213  | File status.
214  | Help message. Explains how to use the server or the meaning of a particular non-standard command. This reply is useful only to the human user.
215  | NAME system type. Where NAME is an official system name from the registry kept by IANA.
220  | Service ready for new user.
221  | Service closing control connection.
225  | Data connection open; no transfer in progress.
226  | Closing data connection. Requested file action successful (for example, file transfer or file abort).
227  | Entering Passive Mode (h1,h2,h3,h4,p1,p2).
228  | Entering Long Passive Mode (long address, port).
229  | Entering Extended Passive Mode (|||port|).
230  | User logged in, proceed. Logged out if appropriate.
231  | User logged out; service terminated.
232  | Logout command noted, will complete when transfer done. Alternatively: User logged in, authorized by security data exchange.
234  | Specifies that the server accepts the authentication mechanism specified by the client, and no security data needs to be exchanged.
235  | Specifies that the server accepts the security data given by the client, and no further security data needs to be exchanged.
250  | Requested file action okay, completed.
257  | "PATHNAME" created.
300 Series  | The command has been accepted, but the requested action is on hold, pending receipt of further information.
331  | User name okay, need password.
332  | Need account for login.
334  | Specifies that the server accepts the authentication mechanism specified by the client, but some security data needs to be exchanged.
335  | Specifies that the server accepts the security data given by the client, but further security data needs to be exchanged.
350  | Requested file action pending further information
400 Series  | The command was not accepted and the requested action did not take place, but the error condition is temporary and the action may be requested again.
421  | Service not available, closing control connection. This may be a reply to any command if the service knows it must shut down.
425  | Can't open data connection.
426  | Connection closed; transfer aborted.
430  | Invalid username or password
434  | Requested host unavailable.
450  | Requested file action not taken.
451  | Requested action aborted. Local error in processing.
452  | Requested action not taken. Insufficient storage space in system. File unavailable (e.g., file busy).
500 Series  | Syntax error, command unrecognized and the requested action did not take place. This may include errors such as command line too long.
501  | Syntax error in parameters or arguments.
502  | Command not implemented.
503  | Bad sequence of commands.
504  | Command not implemented for that parameter.
530  | Not logged in.
532  | Need account for storing files.
534  | Request denied for policy reasons.
550  | Requested action not taken. File unavailable (e.g., file not found, no access).
551  | Requested action aborted. Page type unknown.
552  | Requested file action aborted. Exceeded storage allocation (for current directory or dataset).
553  | Requested action not taken. File name not allowed.
600 Series  | Replies regarding confidentiality and integrity
631  | Integrity protected reply.
632  | Confidentiality and integrity protected reply.
633  | Confidentiality protected reply.
10000 Series  | Common Winsock Error Codes[2] (These are not FTP return codes)
10054  | Connection reset by peer. The connection was forcibly closed by the remote host.
10060  | Cannot connect to remote server.
10061  | Cannot connect to remote server. The connection is actively refused by the server.
10065  | No route to host / DNS cannot be resolved.
10066  | Directory not empty.
10068  | Too many users, server is full.

## References

[Wikipedia FTP response codes](https://en.wikipedia.org/wiki/List_of_FTP_server_return_codes)
