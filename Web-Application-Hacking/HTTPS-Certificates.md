#  HTTPS Certificates


**Warning `Get certs with openssl` of this article were created with `Phind 3.5` and human consultation of `[superuser - how-to-save-a-remote-server-ssl-certificate-locally-as-a-file](https://superuser.com/questions/97201/how-to-save-a-remote-server-ssl-certificate-locally-as-a-file) and tested on see references for Box Spoiler` 

#### Get certs with openssl


[[FireFox]] will allow you to view certificates, but not acquire them try: 
```bash
echo | openssl s_client -servername hostname -connect $domainORIP:443 2>/dev/null | openssl x509 -outform PEM > $customCERT.crt
```
Phind's source: [superuser - how-to-save-a-remote-server-ssl-certificate-locally-as-a-file](https://superuser.com/questions/97201/how-to-save-a-remote-server-ssl-certificate-locally-as-a-file)

## References

[superuser - how-to-save-a-remote-server-ssl-certificate-locally-as-a-file](https://superuser.com/questions/97201/how-to-save-a-remote-server-ssl-certificate-locally-as-a-file)
[Phind](www.phind.com)
[HTB - Box spoiler](https://github.com/7RU7H/CTFs/tree/main/HackTheBox/Retired-Machines/LaCasaDePapel)