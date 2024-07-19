# TALK Pwning the Domain With Sliver Framework

[YouTube Bishop Fox - Pwning the Domain With Sliver Framework](https://www.youtube.com/watch?v=PPNvN3P3ioY) description: *"Mastering the art of adversarial emulation with the most cutting-edge and advanced techniques is one of the keys to success for penetration testers. A definitive hallmark of an experienced ethical hacker is a meticulously crafted toolkit. But with an overwhelming array of tools at your disposal, how do you determine where to focus your efforts? During our exclusive livestream, watch how our renowned senior security expert, Jon Guild, leverages Bishop Fox’s Sliver, an open-source Red Team framework created by fellow Foxes Joe Demesy & Ronan Kervella, to refine his offensive security strategies and techniques. Gain valuable insights from Jon's first-hand experience in a vulnerable lab environment, covering pivotal techniques such as enumeration, lateral movement, and escalation. Be ready to level up your hacking skills at the conclusion of this training session with actionable tips and tricks. Join us to uncover the untapped potential of Sliver and take your offensive security skills to new heights. You’ll have the opportunity to dive into the world of Sliver and learn: - How to pwn the domain using Sliver - Techniques for developing and refining technical methodologies using the Sliver framework - A live demo highlighting Jon’s Sliver knowledge and expertise"*

This is sequel to [[TALK-Ace-The-OSEP-Exam-with-Sliver-Framework]]

[[Sliver]]

Recap:
- Recent changes to GOAD
- Starting on Meeren in Essos domain from
	- From Kali ASREP roast to `khal.drogo`
	- Owned `braavos` server
	- Enumerated with Bloodhound
	- [[GenericAll]] on `viserys`
	- Attempt KrbRelay for Privilege Escalation
	- Use [GitHub - KrbRelayUp](https://github.com/Dec0ne/KrbRelayUp) 
		- Explanation [gist Tothi - No-Fix Local Privilege Escalation from low-priviliged domain user to local system on domain-joined computers.](https://gist.github.com/tothi/bf6c59d6de5d0c9710f23dae5750c4b9)

To clarify variable usage:
```bash
$SRC..., $DST... = (for domain or other identifiers); src = local, dst = remote
```

Because of where we are in are long term attack path, Jon can add a computer with the *Horse password user*... with [[Impacket-Cheatsheet]] and [[ldeep]] (a wrapper around `ldapsearch`) to verify; **Authorial Opinion**: *learn how rough [[LDAP-Recon]] is to understand LDAP, before using the easy way, LDAP is used in internal application probably more than RPC (proof the amount of CTF that use LDAP is vastly greater than RPC)*
```bash
impacket-addcomputer $domain.$tld/$username -computer-name '$cpName' -computer-pass 'P@ssword1' -dc-ip $DSTdcIP
```  

Use [[Krbrelayup]] to Privilege Escalate *not* Lateral movement; we are on DC coercing the LDAP server to abuse `msDS-AllowedToActOnBehalfofotherIdentity` (fancy way of saying Resource based Constrained Delegation) - the machine can write to its own `msDS-AllowedToActOnBehalfofotherIdentity` and update this to want we want. Use `checkPort.exe` to get the correct port: [gist Tothi - No-Fix Local Privilege Escalation from low-privileged domain user to local system on domain-joined computers.](https://gist.github.com/tothi/bf6c59d6de5d0c9710f23dae5750c4b9)
```go
// Use relay to resource constrained delegation - valuable to know this
// Other is shadowprint
krbrelayup '' relay -m rbcd -cls $CLSchooseTrustInstallerItsGoodByServer -p $port -cn '$computerName' -cp 'P@ssword1' -d $doman.$tld
// Check Machines and Delegations with LDAP for confirmation
```

Use Rubeus for RBCD
```go
rubeus -i -M -- hash / password:P@ssword1 /user:$computerName /domain:$DSTdomain.$tld
```
## References

[YouTube Bishop Fox - Pwning the Domain With Sliver Framework](https://www.youtube.com/watch?v=PPNvN3P3ioY) 
[GitHub - KrbRelayUp](https://github.com/Dec0ne/KrbRelayUp) 
[gist Tothi - No-Fix Local Privilege Escalation from low-privileged domain user to local system on domain-joined computers.](https://gist.github.com/tothi/bf6c59d6de5d0c9710f23dae5750c4b9)
