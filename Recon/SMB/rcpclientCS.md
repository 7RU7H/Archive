# rpcclient Cheatsheet
```
querydispinfo
srvinfo

lookupdomain $domain
querydominfo
enumdomusers
enumalsgroups builtin
enumdomgroups
netshareenum
netshareenumall
netsharegetinfo Confidential
querygroup $0xRID
queryuser
enumprivs
getdompwinfo
getusrdompwinfo $0xRID
lsaenumsid
# Enumerating LSA Group Privileges
lsaenumsid
lookupsids $S-1-1-0
lsaenumacctrights $S-1-1-0
lsaaddpriv $S-1-1-0 SeCreateTokenPrivilege
lsaenumprivsaccount S-1-1-0
lsadelpriv $S-1-1-0 SeCreateTokenPrivilege
lsaenumprivsaccount $S-1-1-0
# Create user
createdomuser hacker
setuserinfo2 hacker 24 Password@1
enumdomusers
# LSA Create Account
lookupnames $user
lsacreateaccount $SID
# Create a dom group
createdomgroup newgroup
# SAM Lookup
samlookupnames $domian $user
samlookuprids $domian $0xRID
# SID Lookup
lsaenumsid
# LSA Queries
lsaquery
lsaquerysecobj
dsroledominfo
# numerating LSA Account Privileges
lookupnames $user
lsaaddacctrights $SID SeCreateTokenPrivilege
lsaenumprivsaccount $SID
lsaremoveacctrights $SID SeCreateTokenPrivilege
lsaenumprivsaccount $SID
```


## References 
[hacking-articles](https://www.hackingarticles.in/active-directory-enumeration-rpcclient/)