# Active Directory Default Security Groups Table

Consider [[Active-Directory-Privileged-Groups]] and this differs for [[Azure-Administration-Azure-Roles-And-RBAC]] where amongst many other thing primarilary ownship and contribution are considered over access control based on role in management cloud assets and data.
Groups | Description
--- | ---
Domain Controllers | All domain controllers in the domain
Domain Guests | All domain guests
Domain Users | All domain users
Domain Computers | All workstations and servers joined to the domain
Domain Admins | Designated administrators of the domain
Enterprise Admins | Designated administrators of the enterprise
Schema Admins | Designated administrators of the schema
DNS Admins | DNS Administrators Group
DNS Update Proxy | DNS clients who are permitted to perform dynamic updates on behalf of some other clients (such as DHCP servers).
Allowed RODC Password Replication Group | Members in this group can have their passwords replicated to all read|only domain controllers in the domain
Group Policy Creator Owners | Members in this group can modify group policy for the domain
Denied RODC Password Replication Group | Members in this group cannot have their passwords replicated to any read|only domain controllers in the domain
Protected Users | Members of this group are afforded additional protections against authentication security threats. [See](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn466518(v=ws.11)?redirectedfrom=MSDN) for more information.
Cert Publishers | Members of this group are permitted to publish certificates to the directory
Read|Only Domain Controllers | Members of this group are Read|Only Domain Controllers in the domain
Enterprise Read|Only Domain Controllers | Members of this group are Read|Only Domain Controllers in the enterprise
Key Admins | Members of this group can perform administrative actions on key objects within the domain.
Enterprise Key Admins | Members of this group can perform administrative actions on key objects within the forest.
Cloneable Domain Controllers | Members of this group that are domain controllers may be cloned.
RAS and IAS Servers | Servers in this group can access remote access properties of users.


Groups | Description
--- | ---
Account Operators | Grants limited account creation privileges
Local Adminstrator Password Solution | Randomises Adminstrator Password, if of this group you can read them


## References

[Microsoft Documentation: Protected Users Group](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn466518(v=ws.11)?redirectedfrom=MSDN)