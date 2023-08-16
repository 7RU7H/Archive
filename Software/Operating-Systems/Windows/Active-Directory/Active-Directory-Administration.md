# Active Directory Administration


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
- Seperating "Bring your own devices"

## Configuring Group Policy

SYSVOL is an essential component of Active Directory and creates a shared directory on an NTFS volume that all authenticated domain users can access with reading permission.

```powershell
gpupdate /force
```

On the DC use `Search -> Group Policy Management` to configure group policy. The `Group Policy Management` application displays the complete OU hierarchy. To configure Group policies:
1. Create a GPO under Group Policy Objects 
	1. Link the GPO to where policies are required to apply.
2. `Right click <Name> Domain Policy -> Edit`
	1. This will open the `Group Policy Management Editor` another directory tree of settings

Important Click-ables by tab:
- Scope
	- Security Filtering - Filter applicability of GPO to a set of Objects
- Details
	- GPO Status - Enabled, All settings disabled, Computer configuration settings disabled, User configuration settings disabled
- Settings
	- Actual contents of GPO#

#### GPO distribution
GPO are distributed to the network share called `SYSVOL`, which is store in the DC, typically all users in  the domain have access to this share. Its default location is `C:\Windows\SYSVOL\sysvol`.

## Authentication

- NetNTLM is considered obselete for good reason.


Consider a better password policy - view current:
```powershell
Get-ADDefaultDomainPasswordPolicy
```

It might be worth reviewing the [UK government's Password advice](https://www.ncsc.gov.uk/collection/passwords/updating-your-approach), which has alot of nuanced advice, but no direct instruction as to what length or how complex - prompt reader for considerations. 

A crude example:
```powershell
Set-ADDefaultDomainPasswordPolicy -Identity $domain -PasswordHistoryCount 10 -MinPasswordLength 12 -ComplexityEnabled $true
```


## Trees

Domain Admins should not have Enterprise Admin level Privileges

## Trusts

Trust Direction
1. One-way trust is contrary to the access directoion
2. Two-way trust relationships are mutually authorise users form the other. By default join mulitple domains under a tree or forest will form a wo-way trust relationship.