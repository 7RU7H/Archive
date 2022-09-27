# Offensive Enumeration With WMI
This is mostly a cheatsheet compile from demonstration of commands  and scripts from the [https://0xinfection.github.io/](https://0xinfection.github.io/), blog. I will list the commands after a Part X header and link to each blog, each is an must read. Also I  found that while learning, manually fumbling over commands [[Black-Box-Method]]ing each observing the output I really enjoyed the way a command would expose  information about the OS.

[0xinfection Offensive blog part 5](https://0xinfection.github.io/posts/wmi-ad-enum/)

## Part 5 
[0xinfection Offensive blog part 5](https://0xinfection.github.io/posts/wmi-ad-enum/)

List out the available classes
```sql
Get-WmiObject -Namespace root\directory\ldap -Class ds_* -List
```

Domain Name
```sql
Get-WmiObject -Namespace root\directory\ldap -Class ds_domain | select ds_dc,
    ds_distinguishedname, pscomputername
```

Domain Policy
```sql
Get-WmiObject -Namespace root\directory\ldap -Class ds_domain | select ds_lockoutduration,
    ds_lockoutobservationwindow, ds_lockoutthreshold, ds_maxpwdage,
    ds_minpwdage, ds_minpwdlength, ds_pwdhistorylength, ds_pwdproperties
```

Domain Controller Location
```sql
Get-WmiObject -Namespace root\directory\ldap -Class ds_computer | where {
    $_.ds_useraccountcontrol -match 532480
} | select ds_cn, ds_dnshostname, ds_operatingsystem, ds_lastlogon, ds_pwdlastset
```

Searching user accounts
```sql
Get-WmiObject -Class win32_useraccount | select name, domain, accounttype
```

```sql
Get-WmiObject -Class win32_useraccount -Filter 'domain="<domain>"' | select caption
```

Currently Logged-on users
```sql
Get-WmiObject -Class win32_loggedonuser | where {
    $_ -match 'infected'
} | foreach {[wmi]$_.antecedent}
```

Fetching groups
```sql
Get-WmiObject -Class win32_groupindomain | foreach {[wmi]$_.partcomponent}
```

Figuring out group memberships
```sql
Get-WmiObject -Class win32_groupuser | where {
    $_.groupcomponent -match 'domain admins'
} | foreach {[wmi]$_.partcomponent}
```

```sql
Get-WmiObject -Class win32_groupuser | where {
    $_.partcomponent -match 'Administrator'
} | foreach {[wmi]$_.groupcomponent}
```

Locate Domain-joined machine
```sql
Get-WmiObject -Namespace root\directory\ldap -Class ds_computer | select ds_cn
```

Enum Admin privileges accross Domain
```powershell
$pcs = Get-WmiObject -Namespace root\directory\ldap -Class ds_computer | select -ExpandProperty ds_cn
foreach ($pc in $pcs) {
    (Get-WmiObject -Class win32_computersystem -ComputerName $pc -ErrorAction silentlycontinue).name
}
```

## References

[https://0xinfection.github.io/](https://0xinfection.github.io/),
[0xinfection Offensive blog part 5](https://0xinfection.github.io/posts/wmi-ad-enum/)