# Tunneling/Port-Forwarding


port forwarding, ssh tunneling
Forwarding in as many ways..


## ssh port forward/tunnelling

```bash
ssh-keygen
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 644 id_rsa.pub

# from attack box
ssh -f -N -L port:127.0.0.1:port user@ip -i id_rsa

-i id_rsa					# If you want to access a remote server using a private key.
-L local_port:remote_address:remote_port	# For local port forwarding. 
-R port:local_address:local_port		# For remote port forwarding.  
-D local_PORT					# Dynamic port forwarding. Creates a socks proxy on localhost. 
-N 						# Do not execute a remote command, useful for just forwarding ports
```
