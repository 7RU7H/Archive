# EVIL-WINRM
Evil-WinRM see [[Shells]] for more [[Shells]] and [[Reverse-Shells]] of [[Reverse-Shells]]

```bash
evil-winrm -i $IP -u $USER -p $PASS
# Enable SSL and use a cert and key file
evil-winrm -S -i $IP -c $keyfile.cert -k $keyfile.pem

```
On remote system use the menu to, any powershell loaded with `. .\Module` will be visible in this `menu` command:
```powershell
menu
```

## Upload/Download Note:
**Notes about paths (upload/download)**: Relative paths are not allowed to use on download/upload. Use filenames on current directory or absolute path. If you are using Evil-WinRM in a docker environment, bear in mind that all local paths should be at `/data` and be pretty sure that you mapped it as a volume in order to be able to access to downloaded files or to be able to upload files from your local host O.S.