# TLS/SSL

[Secure Socket Shell](https://en.wikipedia.org/wiki/Transport_Layer_Security#SSL_1.0,_2.0,_and_3.0) (SSL) - now deprecated, but [Transport Layer Security](https://en.wikipedia.org/wiki/Transport_Layer_Security) (TLS) is built on top of it. TLS is a cryptographic protocol to secure network communication. TLSD is closely related to Datagram Transport Layer Security and in  runs in the Presentation Layer of the [[OSI-Model]].

```goat
Client -> Client Hello Message (TLS version, cipher suite plus random bytes) -> Server 
Client <- Server Hello Message (certificate and cipher suite plus random bytes) <- Server
Client -> Authenication -> Server
Client -> Premaster secret (server public key + random bytes ) -> Server
Client <- Decryption premaster secretwith server private key <- Server
Client <-> Sessions key generated (with client's random bytes), but not transmitted <-> Server
Client <-> Ready Messages ("finished" message) <-> Server
Client <-> Encrypted Sessions <-> Server
```

## References

[THM Network Security Protocols](https://tryhackme.com/room/networksecurityprotocols)
[Secure Socket Shell](https://en.wikipedia.org/wiki/Transport_Layer_Security#SSL_1.0,_2.0,_and_3.0)
[Transport Layer Security](https://en.wikipedia.org/wiki/Transport_Layer_Security)