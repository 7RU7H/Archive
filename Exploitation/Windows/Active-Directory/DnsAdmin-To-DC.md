# DnsAdmin To DC

Members of the DnsAdmin group, see [[Active-Directory-Default-Security-Groups-Table]] table showing relative relation to other default AD groups can perform [[DLL-Injection]] into the DNS process running as System to escalate when that service restarts. This also requires AD to be present as it is form of [[Active-Directory-Privilege-Escalation]].

Requires either:
- Compromised Dnsadmin group member 
- Write privileges to a DNS server object.



https://medium.com/r3d-buck3t/escalating-privileges-with-dnsadmins-group-active-directory-6f7adbc7005b
https://www.hackingarticles.in/windows-privilege-escalation-dnsadmins-to-domainadmin/

https://lolbas-project.github.io/lolbas/Binaries/Dnscmd/

https://www.ired.team/offensive-security-experiments/active-directory-kerberos-abuse/from-dnsadmins-to-system-to-domain-compromise

[Ippsec](https://www.youtube.com/watch?v=8KJebvmd1Fk) showcases a compilation of shellcode that will also not crash the DNS server for a more OPSEC safe method of privilege escalation, from [ired](https://www.ired.team/offensive-security-experiments/active-directory-kerberos-abuse/from-dnsadmins-to-system-to-domain-compromise).

1. Download https://github.com/dim0x69/dns-exe-persistance - template code for a DNS DLL plugin
2. Open .sln file in Visual Studio
3. 