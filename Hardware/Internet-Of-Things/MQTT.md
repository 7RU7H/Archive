#  MQTT

[Hacktricks describes MQTT](https://book.hacktricks.xyz/network-services-pentesting/1883-pentesting-mqtt-mosquitto) as *MQTT stands for MQ Telemetry Transport. It is a publish/subscribe, **extremely simple and lightweight messaging protocol**, designed for constrained devices and low-bandwidth, high-latency or unreliable networks."*

The Publish/Subscribe model:
- **Publisher**: publishes a message to one (or many) topic(s) in the broker.
- **Subscriber**: subscribes to one (or many) topic(s) in the broker and receives all the messages sent from the publisher.
- **Broker**: routes all the messages from the publishers to the subscribers.
- **Topic**: consists of one or more levels that are separated by a a forward slash (e.g., /smartshouse/livingroom/temperature).

Publisher -> Broker(brokers Topic(s)) -> Subscriber

## MQTT Packet Format and Types

Bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
--- | --- |  --- |  --- |  --- |  --- |  --- |  --- |  ---
Byte 1 | MQTT Control Packet type | ... | ... | ... | Flags Specific to each MQTT Control Packet type  | ... | ... | .... 
Byte 2 | Remaining length | ... | ... | ... | ... | ... | ... | ... 


Name | Value | Direction of flow | Description
--- | --- | --- | ---
Reserved | 0 | Forbidden | Reserved
CONNECT | 1 | Client to Server | Client request to connect to SErver 
CONNACK | 2 | Server to Client | Connect acknowledgement
PUBLISH | 3 | Client to Server or Server to Client | Publish message
PUBACK | 4 | Client to Server or Server to Client  | Publish acknowledgement
PUBREC | 5 | Client to Server or Server to Client | Publish received (assured delivery part 1)
PUBREL | 6 | Client to Server or Server to Client | Publish release (assured delivery part 2)
PUBCOMP | 7 | Client to Server or Server to Client | Publish release (assured delivery part 3)
SUBSCRIBE | 8 | Client to Server | Client subscribe request 
SUBACK | 9 | Server to Client | Subscribe acknowledgement
UNSUBSCRIBE | 11 | Server to Client | Unsubscribe acknowledgement
PINGREQ | 12 | Client to Server | PING request
PINGRESP | 13 | Server to Client | PING response
DISCONNECT | 14 | Client to server | Client is disconnecting
Reserved | 15 | Forbidden | Reserved 

## Mosquitto Client and Alternatives

Requires `mosquitto_sub` and `mosquitto_pub` -  `apt install mosquitto-client` - is a simple MMQT client that will subscribe to a single topic and print all messages it receives.
 
```bash
nmap -sC -sV -p 1883 $ip
mosquitto_sub -h $hostIP -t $topicToSubTo
```

1. Hack the message! - Reverse Engineer or Source Code analysis
1. Setup a listener
1. Send a message to the broker to send redirect target output to listener device of your choosing

```bash
mosquitto_pub -h $host -t $device/info -m "Insert Message Here!"
-d # Enable Debug messages
-i # specify an id to identify the client to server 
-u # username
-P # password
-p # port
-url # specify username, password, host, port and topic in one URL
```

[mqtt-pwn](https://github.com/akamai-threat-research/mqtt-pwn) intends to be a one-stop-shop for IoT Broker penetration-testing and security assessment operations.

## Attacking

No Authentication 
```bash
mosquitto_sub -h $ip -t '#' -v
```

[[Metasploit]] for dictionary attacks 
```ruby
msf6 > use auxiliary/scanner/mqtt/connect
msf6 auxiliary(scanner/mqtt/connect) > set PASS_FILE /tmp/passwords.txt
msf6 auxiliary(scanner/mqtt/connect) > set USER_FILE /tmp/users.txt
msf6 auxiliary(scanner/mqtt/connect) > set RHOST <insert here>
```




## References

[THM AoC4](https://tryhackme.com/room/adventofcyber4)
[Security Cafe](https://securitycafe.ro/2022/04/08/iot-pentesting-101-how-to-hack-mqtt-the-standard-for-iot-messaging/)
[mqtt-pwn](https://github.com/akamai-threat-research/mqtt-pwn) 
[Hacktricks - MQTT](https://book.hacktricks.xyz/network-services-pentesting/1883-pentesting-mqtt-mosquitto) 