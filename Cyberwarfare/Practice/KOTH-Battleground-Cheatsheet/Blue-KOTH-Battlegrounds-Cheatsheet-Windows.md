# Blue Windows

Remove unwanted SMB shares
```powershell
Remove-SmbShare -Name "badSMB" -Force

# Remove all the SMB shares
Get-SmbShare | ForEach-Object {
  Remove-SmbShare -Name $_.Name -Force
}
```