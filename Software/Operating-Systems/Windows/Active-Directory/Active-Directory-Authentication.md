# Active Directory Authentication

Active Directory supports multiple authentication protocols and techniques and implements authentication to Windows, Linux amd MacOS. For more basics of cryptography see [[Cryptography]]. For how AD caches the hashes see [[Active-Directory-Credential-Caching]].

With Microsoft's approach to backway compatibility older operating systems like Windows 7 or Windows Server 2008 R2, can be incorperated into Active Directory. Therefore AD still supports several older protocols including [WDigest](https://technet.microsoft.com/en-us/library/cc778868(v=ws.10).aspx).

**IP vs Hostnames**

Command  | Network Protocol | Authentication 
--- | --- | ---
`dir \\<DC IP>\SYSVOL` | IP | NTLM
`dir \\domain_name\SYSVOL` | DNS | Kerberos authentication


## NTLM Authentication
- **Use**
1. Used in client to server authenication
1. Used in user authenication to a hostname not registered on the AD integrated DNS server.

- **Authentication Process**
1. Calculation of cryptographic hash
2. Client Machine sends `user name` -> `server`; Server -> returns a random value called either `nouce/challenge`  
3. Client Machine encrypts the `nouce/challenge` with the NTLM hash called a `response`
4. Client Machine responds with the `response` -> Server
5. Server forward to the `response` to DC.
6. DC encrypt the `nouce/challenge`  itself with its stored version of the NTLM hash to make a comparison with the forwarded `response`

## Kerberos Authentication
For detailed explainations of [[Active-Directory-Kerberos-Authentication-Defined]] and for [[Attacking-Kerberos]] follow the links. The Kerberos authentication protocol used by Microsoft is adopted from the Kerberos version 5 authentication protocol created by MIT and has been used as Microsoft's primary authentication mechanism since Windows Server 2003. It uses a ticket system to ensure an intermediary gatekeeping by the DC as role of key distribution (KDC) for service usage from non-DCs. A example of this process is outlined in [[Active-Directory-Kerberos-Authentication-Defined]].


## References
[WDigest](https://technet.microsoft.com/en-us/library/cc778868(v=ws.10).aspx)
