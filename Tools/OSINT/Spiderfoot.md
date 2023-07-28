# Spiderfoot

[Spiderfoor](https://github.com/smicallef/spiderfoot) *"automates OSINT for threat intelligence and mapping your attack surface ..SpiderFoot is an open source intelligence (OSINT) automation tool. It integrates with just about every data source available and utilises a range of methods for data analysis, making that data easy to navigate.
- Features:
	- Web based UI or CLI
	- Over 200 modules
	- Python 3.7+
	- YAML-configurable [correlation engine](https://github.com/smicallef/spiderfoot/blob/master/correlations/README.md) with [37 pre-defined rules](https://github.com/smicallef/spiderfoot/blob/master/correlations)
	- CSV/JSON/GEXF export
	- API key export/import
	- SQLite back-end for custom querying
	- Highly configurable
	- Fully documented
	- Visualisations
	- TOR integration for dark web searching
	- Dockerfile for Docker-based deployments
	- Can call other tools like DNSTwist, Whatweb, Nmap and CMSeeK
	- [Actively developed since 2012!](https://medium.com/@micallst/lessons-learned-from-my-10-year-open-source-project-4a4c8c2b4f64)
	- For more go to [intel471](https://intel471.com/solutions/attack-surface-protection)
- You can target the following entities in a SpiderFoot scan:
	- IP address
	- Domain/sub-domain name
	- Hostname
	- Network subnet (CIDR)
	- ASN
	- E-mail address
	- Phone number
	- Username
	- Person's name
	- Bitcoin address

Make a docker container for Spiderfoot
```bash
git clone https://github.com/smicallef/spiderfoot.git
cd spiderfoot/
docker build -t spiderfoot .
```
Running as a Docker Container - **beware we are exposing this on 0.0.0.0** - consider `proxychains` with [[Proxies]]
```bash
# Usage:
sudo docker build -t spiderfoot .
sudo docker run -p 5001:5001 --security-opt no-new-privileges spiderfoot
# Using Docker volume for spiderfoot data
sudo docker run -p 5001:5001 -v /mydir/spiderfoot:/var/lib/spiderfoot spiderfoot
# Using SpiderFoot remote command line with web server
docker run --rm -it spiderfoot sfcli.py -s http://my.spiderfoot.host:5001/
# Running spiderfoot commands without web server (can optionally specify volume)
sudo docker run --rm spiderfoot sf.py -h
# Running a shell in the container for maintenance
sudo docker run -it --entrypoint /bin/sh spiderfoot
# Running spiderfoot unit tests in container
sudo docker build -t spiderfoot-test --build-arg REQUIREMENTS=test/requirements.txt .
sudo docker run --rm spiderfoot-test -m pytest --flake8 .
```

## References

[Spiderfoor](https://github.com/smicallef/spiderfoot) 