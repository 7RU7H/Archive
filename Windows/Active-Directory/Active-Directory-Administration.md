## Active Directory Administration

This article will eventual contain as must bare-bones guidance on applications and some configuration. So if you [[Active-Directory-Privilege-Escalation]] to some form of [[Active-Directory-Persistence]] and now need to become the DC to some Administration, hopeful this article will have you covered. But to attack is defend without defending and to defend is to attack without attacking the circle of Microsoft Windows and the fools that use, hack and sysadmin it go on. Simply put more as a reminder for myself to put in time to learn how the mechanicism operator as well as how they should not.  

Having started out never Adminstating AD to taking just trying to take OSCP(with the update AD exam), this **IS  NOT** certified list of do-s and don't-s, but more a article to compress the knownledge of others in a simple checklist  of **run x**, **do y**, **DO NOT DO A,B,C** and read the manuals or links provided. If you just want AD  information read [[Active-Directory-Defined]], but if you feel like you need to test things out go to article on making a [[Active-Directory-Lab]] before doing anything on your workplace's fancy production environments.

1. Links are either external Documentation, Blogs or Internal links
1. Red flags indicated with **!!RED-FLAG!!** - *"DO X OR BE SQUARE"**


## Configuring Users, Groups and Machines
On the DC use `Search -> Active Directory Users and Computers` to configure users, groups or machines

#### Delegation

`Right-Click On OU -> Delegate Control `

#### Deleting an OU
OUs are protected against accidental deletion, to delete:  `View -> Advanced Features -> Object -> Disable: Project object from accidental deletion`

#### Changing a Password
```powershell
Set-ADAccountPassword <username> -Reset -NewPassword (Read-Host -AsSecureString -Prompt 'New Password') -Verbose
# Force password reset on next logon
Set-ADUser -ChangePasswordAtLogon $true -Identity <username> -Verbose
```


#### Machine Organisation
Segregating devices according to their use
- May prevent over generalisation of a group policy
-  Seperating "Bring your own devices"

## Configuring Group Policy

On the DC use `Search -> Group Policy Management` to configure group policy