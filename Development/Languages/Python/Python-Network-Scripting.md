# Python Network Scripting

## Client

The variable `s` is assign a socket object that takes a socket family, socket type and protocol as arguments: `s = socket.socket(<socket_family>, <socket_type>, <protocol>)`. 
Socket family specifies protocol domain:
1. `AF_INET` for IPv4 addressing
1. `AF_INET6` for IPv6 addressing
1. `AF_UNIX` for Unix Domain Sockets(allows the operating system to pass data directly from process to process, without going through the network stack)
1. `AF_BLUETOOTH` Bluetooth addressing
1. `AF_PACKET` is low-level interface directly to network devices

Socket type should be
1. `SOCK_STREAM` for TCP - is default
2. `SOCK_DGRAM` for UDP
3. `SOCK_RAW`  *"allows an application to directly access lower level protocols, which means a raw socket receives un-extracted packets"*[opensourceforu](https://www.opensourceforu.com/2015/03/a-guide-to-using-raw-sockets/)

Protocol is used to specifiy protocol number! Default is 0

Socket API functions:
-   `socket()`
-   `.bind()`
-   `.listen()`
-   `.accept()`
-   `.connect()`
-   `.connect_ex()`
-   `.send()`
-   `.recv()`
-   `.close()`

Simple client
```python
#!/usr/bin/python3
import socket

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM) # Socket Object
#localhost = socket.gethostname() # Localhost name!
port = 80
client.connect(("www.domain.com", port)) # double parenthesises the socket lib would treat this as one argument

msg = client.recv(1024) # Defines a buffer size of 1024 to receive 1024 bits of data 
client.close()
print (msg.decode('ascii')) # decodes the buffer in a format! Beware ascii is not modern

```


More complex client

```python


```


## Considerations

Use with to automatically close after use.
```python
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as client:
	# socket stuff! BUT you don't need to close it will supported by context manager type
	pass
```



## References
[Socket documentation](https://docs.python.org/3/library/socket.html)
[RealPython Socket Programming](https://realpython.com/python-sockets/)
[opensourceforu](https://www.opensourceforu.com/2015/03/a-guide-to-using-raw-sockets/)
[Socket Programming HowTo](https://docs.python.org/3/howto/sockets.html)