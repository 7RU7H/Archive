## Seriously, I Really Can Still See You. - Talk

[Seriously, I Really Can Still See You by John Ham](https://www.youtube.com/watch?v=tvrF0TKPAdQ)

Description: *"From Wild West Hackin' Fest 2018 in Deadwood, SD. Presenter: Jonathan Ham Jonathan is an independent consultant who specializes in large-scale enterprise security issues, from policy and procedure, through team selection and training, to implementing scalable prevention, detection, and response technologies and techniques. With a keen understanding of ROI and TCO (and an emphasis on real-world practice over products), he has helped his clients achieve greater success for over twenty years, advising in both the public and private sectors, from small startups to the Fortune 50, the U.S. Department of Defense across multiple engaged forces, and several other US federal agencies. Follow Wild West Hackin' Fest on Twitter here: [https://twitter.com/wwhackinfest](https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbVRYSlh3UmFLdUxoVXFiUUxzNnpEdTlTU3FIQXxBQ3Jtc0ttYnFBbnVJbWtHTDF3QmFXSHc4WEZ4cmt0U3hwcGJyWXItQ09yc3dTNHZQeTA3M3BicFE4NVRJQmRqbGRYb3BhLVdQMVo5Ml9ULTVfNzltdVRKc1dCajIyUHBkVEtvcVFMaXhjajlTbEJ5eWRLR3RPRQ&q=https%3A%2F%2Ftwitter.com%2Fwwhackinfest&v=tvrF0TKPAdQ) Website & Info: [https://www.wildwesthackinfest.com/](https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqa2kyajRLdUlCNFhJeU9rcXFMQ0kzdms4VTRXUXxBQ3Jtc0trUmZObWJvVHBZdFg1LXhOUlY5bnpuRlV2MDlucm9iU0tiZGY0TFlJWlhRX3J5WGR2WlVTN1h1OG5qTWdlTDdQQXFQSG9URzNCZnBxR1RvaEVaOXRaVlNiOUVSWUl3elMyaFZEYmJycmpyUkNGY3RlTQ&q=https%3A%2F%2Fwww.wildwesthackinfest.com%2F&v=tvrF0TKPAdQ)"*

Beware Bro is renamed to [[Zeek]]!


Who does not know there login context? - SysAdmins and Bad guys
```powershell
whoami 
# Event ID: 4688
# ProviderName: Microsoft-Windows-Security-Audit
```

All analysis is done quick and dirty - deliberate limitations to prove what you can get without full content:
- No inspection beyond what is easily instrumented
	- Network flow data, traffic analysis, corrrelated transactions
	- [[Snort]] - [[Zeek]] default configs/rules/scripts/ only (mostly)
	- CLI inspection 
	- Nothing that can be scripted for instant alerting
- Full content inspection:
	- No [[Wireshark]] or [[Tshark]]
	- No session reconstruction for L7 content (much)

- Inital Reconnaissance
	- When X starts and ends
	- What are boxes on the nwetwork doing
	- what protocols aer involved - any obvious abnormalities
	- Who is who?
- Drill down (desiminate or remove normal behavious data) anomalous behaviour 
	- Who is bad?
	- What bad is happening to Y?
	- Did bad propagate?
- Timeline analysis
	- Putting events in context - correlation?
	- Understanding sequence of those events

1. Get timeline boundaries, process the pcap
```bash
# Tell snort everything is inside and outside
snort -q -A full -r $pcap.pacp -c snort_readin.conf
bro -r $pcap.pcap local.bro
# How big is connections log?
wc -l conn.log 
```
2. Quick glance at snort alerts - the few things in the long tail of snorty the pig
```bash
# Remove ascii art and in numerical and in reverse
egrep '\[\*\*\]' alert| sort | uniq -c | sort -nr
# Look for uncommon snort alerts
```
3. What ports arte in play and who is listening?
```bash
cat conn.log|bro-cut id.resp_p | sort|uniq -c|sort -nr
# Ports you do not know? It is probably evil
```
4. Bad actors are talking on port X/tcp - *"it takes longer to get this than to see the C2"*
```bash
cat conn.log|bro-cut -d ts uid.orig_h id.resp_h id.resp_p orig_byte resp_bytes|grep $port
```
5. How did it get that way?
```bash
# URIs
cat http.log|bro-cut id.resp_p uri| grep $port | sort |uniq -c|sort -nr
# URI status codes 
cat http.log|bro-cut id.resp_p uri status_code | grep $port | sort |uniq -c|sort -nr
# Plus HTTP methods, req and rsp body lengths
cat http.log|bro-cut id.resp_p uri method request_bodyu_len response_body_len | grep $port | sort |uniq -c|sort -nr
```
6. How did it get that way part 2 - drill down further? Look at the bytes numbers are they static or random are the patterns and what is the sequence?
```bash
cat conn.log|bro-cut -d ts uid.orig_h id.resp_h id.resp_p orig_byte resp_bytes|grep $port| head
# What about $port?
cat conn.log|bro-cut id.resp_p | sort -u
# if its http traffic otherwise use the correct logs! 
cat http.log|bro-cut id.resp_p uri | grep $port | sort |uniq -c|sort -nr |head
# TALK: 201 is acting as web proxy for 202 web surfing needs 
cat http.log|bro-cut id.resp_p uri proxied| grep $port | sort |uniq -c|sort -nr| head
```
Recurse: Why are they so EVIL and how did they get that way?

![](wwh-seriouslyireallycanstillseeyou-llmnrandwpadprimer.png)

LLMNR 
```bash
# No IPv6
cat conn.log|bro-cut id.orig_h id.resp_h id.resp_p| sort |uniq -c|sort -nr| |grep 5355 | grep -v fe80::
```

Snort complained about WPAD - 202 is asks multicast for wpad and 201 replies its me:
```bash
cat dns.log|bro-cut id.orig_h id.orig_p id.resp_h id.resp_p query anaswer|grep 5355 |grep wdap| grep -v fe80:: | grep -v - 
# Get transaction id and for each of these and inspect dns.log with bro, grepping out IPv6 and grepping in txids
for txid in `cat dns.log|bro-cut  id.resp_p trans_id query answer|grep 5355 |grep wdap| grep -v fe80:: | grep -v - | awk '{print $2}'`; do cat dns.log | bro-cut id.orig_h id.orig_p id.resp_h id.resp_p query answer| egerp [^0-9]$txid[^0-9]|grep -v 'fe80::' ; done 
```

Timeline information 
```bash
cat dns.log|bro-cut -d ts id.orig_h id.orig_p id.resp_h id.resp_p query anaswer | grep 5355 |grep wdap| grep -v fe80:: | grep -v '\-$' 
# What is then happening timestamp-wise with HTTP
cat http.log|bro-cut -d ts id.orig_h id_resp_h method uri status_code resp_mime_types response_body_len |grep wpad.dat
```

```bash
# Define where LLMNR wpad resolution should NOT come from
global home_subnet: set[subnet] = {$subnet/$cidr};

# Dynamically collect IPs where it IS coming from, and log the event
global LLMNR_wpad_resolvers: addr_set;
event dns_A_reply(c: connection, msg: dns_msg, ans: dns_answer, a: addr) {
	if (c$id$resp_p == 5355/udp &&
	c$id$resp_h in home_subnet &&
	ans$query == "wpad") {
		add LLMNR_wpad_resolvers[c$id$$resp_h];
		NOTICE([$note=Weird::Activity, $conn=c,
			$msg=fmt("****ALERT*** %s used LLMNR to resolve query \"%s\" to addr %s for %s!", c$id$resp_h ans$query, a, c$id$orig_h)]);
	} 
}

# If a subsequent download of a wpad.dat occurs, parse it and log it
event http_entity_data(c: connection, is_orig: bool, length: count, data: string) {
	if (c$id$resp_h in LLMNR_wpad_resolvers &&
		c$id$resp_p == 80/tcp &&
		c$ihttp$host == "wpad" &&
		c$http$method == "GET" &&
		c$http$uri == "/wpad.dat") {
			NOTICE([$note=Weird::Activity, $conn=c,
			$msg=fmt("****ALERT*** %s served %s byte wpad.dat file to %s via 80/tcp!", c$id$resp_h, length, c$id$orig_h),
			$sub=fmt("DAT FILE DATA: %s" data)]);
		}
}
```

What did John get?
```bash
bro -r $pcap.pcap local.bro ./LLMNR_WPAD_download.bro
cat notice.log|bro-cut id.orig_h id.orig_p id.resp_h id.resp_p msg sub| grep ALERT|head -2
# For the talk this return ISAProxySrv = 201 is being proxied web traffic which wpad.dat file
```

John's punchline - it me too, 201 pwn 202 as a MiTM for all its web traffic
```bash
cat dns.log |bro-cut id.orig_h id.orig_p id.resp_h id.resp_p query anaswer | grep 5355 |grep -i ISAProxySrv|grep -v fe80:: | grep -v - 
```


Admissions of Weakness:
- You have to be appropriately instrumented and we too rarely are:
	- Local of visibility into lateral movement points
	- Lack of detection of post-exploitation in general
	- But this is what is fixable
- Exploitation is hard to see, for most.
	- Stage 1 flies by detection, no matter whose stuff you buy
	- Stage 2 room though that is less excusable
- Post-exploitation is what's easy to see
	- But still you have to be looking!
	- Can't pull all the C2 apart from trolling Social Media. That's hard
	- Likewise with exfiltration. Pretty much the same.
- But quickly identifying the Bad Actors is totally doable 

In the domain of the blind, the one-eyed man sees the new Domain Admin.

Go buy the book! - Network Forensics: Tracking Hackers Cyberspace

## References

[Seriously, I Really Can Still See You by John Ham at Wild West Hackin' Fest](https://www.youtube.com/watch?v=tvrF0TKPAdQ)