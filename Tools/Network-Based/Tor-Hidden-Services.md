# Tor 

![](Onion_diagram.png)

Tor manpage: *"" Tor is a connection-oriented anonymizing communication service. Users choose a source-routed path through a set of nodes, and negtiate a "virtual circuit" through the network. Each node in a virtual circuit knows its predecessor and successor nodes, but no other nodes. Traffic flowing down the circuit is unwrapped by a symmetric key at each node, which reveals the downstream node."*

## Installation

```bash 
apt-get install tor
service tor start # Ubuntu
service tor status # Ubuntu
serivce tor stop # Ubuntu
```


## How Tor works:
[Stackover 2013](https://tor.stackexchange.com/questions/672/how-do-onion-addresses-exactly-work)

1.  A hidden service calculates its key pair (private and public key, asymmetric encryption).
2.  Then the hidden service picks some relays as its _introduction points_.
3.  It tells its public key to those _introduction points_ over Tor circuits.
4.  After that the hidden-service creates a _hidden service descriptor_, containing its public key and what its _introduction points_ are.
5.  The hidden service signs the _hidden service descriptor_ with its private key.
6.  It then uploads the _hidden service descriptor_ to a _distributed hash table_ (DHT).
7.  Clients learn the .onion address from a hidden service out-of-band. (e.g. public website) (A $hash.onion is a 16 character name derived from the service's public key.)
8.  After retrieving the .onion address the client connects to the DHT and asks for that $hash.
9.  If it exists the client learns about the hidden service's public key and its _introduction points_.
10.  The client picks a relay at random to build a circuit to it, to tell it a _one-time secret_. The picked relay acts as _rendezvous point_.
    
11.  The client creates a _introduce message_, containing the address of the _rendezvous point_ and the _one-time secret_, before encrypting the message with the hidden service's public key.
    
12.  The client sends its message over a Tor circuit to one of the _introduction points_, demanding it to be forwarded to the hidden service.
13.  The hidden service decrypts the _introduce message_ with its private key to learn about the _rendezvous point_ and the _one-time secret_.
14.  The hidden service creates a _rendezvous message_, containing the _one-time secret_ and sends it over a circuit to the _rendezvous point_.
15.  The _rendezvous point_ tells the client that a connection was established.
16.  Client and hidden service talk to each other over this _rendezvous point_. All traffic is end-to-end encrypted and the _rendezvous point_ just relays it back and forth. Note that each of them, client and hidden service, build a circuit to the _rendezvous point_; at three hops per circuit this makes six hops in total.

## Proxychaining Tor

```bash
# Edit /etc/proxychains.conf
# Uncomment dynamic_chain
# Comment any *_chain and proxy_dns
tor
proxychains firefox
```

Go to [dnsleaktest.com](https://dnsleaktest.com) to test if you IP has changed and see [[DNS-Leaking]] article which based on `dnsleaktest.com/what-is-a-dns-leak.html`

## Tor Browser
Coming Soon...


## Tor Exploitation

From the Schneier On Security artical: [How the NSA Attacks Tor/Firefox Users With QUANTUM and FOXACID](https://www.schneier.com/blog/archives/2013/10/how_the_nsa_att.html) - TLDR:
- NSA compromise or setup public internet servers (FoxAcid Servers - exploit orchestrator an Internet-enabled system capable of attacking target computers) and corresponding links to those servers to "fingerprint" Users by correlating  them with Database and Inhouse Tools to: 
	- Filter collection to find patterns of TOR use as TOR traffic is anomalous to regular traffic
	- XKeyscore to view "almost everything" a target does on the Internet. 

FoxZAcid servers have innocuous tags in URI 

## References

[Stackexchange 2013](https://tor.stackexchange.com/questions/672/how-do-onion-addresses-exactly-work)
[THM Tor for Beginners room](https://tryhackme.com/room/torforbeginners)
[dnsleaktest.com](https://dnsleaktest.com)
[How the NSA Attacks Tor/Firefox Users With QUANTUM and FOXACID](https://www.schneier.com/blog/archives/2013/10/how_the_nsa_att.html)