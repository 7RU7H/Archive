# Red Windows

Website 
`Ctrl + Shift + R` - cache refresh pages to ensure last game does not misform as to current context


```powershell


```


I NEED TO TEST THIS:

You may want to create all the secondary drives or all the drives possible to block others from using any of the drives. 
```powershell
$persistenceUser = "User1"

for ($i=0; $i -lt 26; $i++) {
  $driveLetter = [char]($i + 65) + ":"
  if (!(Get-Volume | Where-Object DriveLetter -eq $driveLetter)) {
    $newDisk = New-VirtualDisk -DriveLetter $driveLetter -Size 25MB
    $acl = Get-Acl -Path $newDisk.DriveLetter
    $persistenceUserRights = [System.Security.AccessControl.FileSystemRights]"FullControl"
    $persistenceUserAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($persistenceUser, $persistenceUserRights, "Allow")
    $acl.SetAccessRule($persistenceUserAccessRule)
    $otherUsersRights = [System.Security.AccessControl.FileSystemRights]"FullControl"
    $otherUsersAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrator", $otherUsersRights, "Deny")
    $acl.SetAccessRule($otherUsersAccessRule)
    Set-Acl -Path $newDisk.DriveLetter -AclObject $acl
  }
}

```

Create a file share - the longer the path for copy and paste and shell nightmares
```powershell
#

# -ConcurrentUserLimit to prevent hacky breaking into destroy the share 

New-SmbShare -Name MyFileShare -Path $goodPath -FullAccess $persistenceUser -EncryptData $True -ConcurrentUserLimit 1 -ContinuouslyAvailable -Temporary
# You can set up an inital connection to a remote host with output from
#  New-CimSession Get-CimSession
-Cim-Session 


# Add to known adversary accounts -NoAccess Administrator

$Parameters = @{
    Name = '$Name'
    Path = $goodPath
    FullAccess = 'Contoso\Administrator', 'Contoso\Contoso-HV1$'
    EncryptData = $True
    Temporary = $True
    ContinuouslyAvailable = $True
    NoAccess = 'Administrator' # Prevent access administrator - create persistence user to access
}
New-SmbShare @Parameters
```