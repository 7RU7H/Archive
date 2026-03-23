# `web-check`

[GitHub - web-check](https://github.com/Lissy93/web-check) *All-in-one OSINT tool for analysing any website. Get an insight into the inner-workings of a given website: uncover potential attack vectors, analyse server architecture, view security configurations, and learn what technologies a site is using. Currently the dashboard will show: IP info, SSL chain, DNS records, cookies, headers, domain info, search crawl rules, page map, server location, redirect ledger, open ports, traceroute, DNS security extensions, site performance, trackers, associated hostnames, carbon footprint.*

This is a really quick, holistic and visually easier way to assess properties of a website than [[Nuclei]], but consider the warnings section before using. If you need a specific property I would suggest running a CLI tool that get that data only.
#### Warning!

If the visibility over security and [[OPSEC]] is an issue this a very nice quick way to assess a site. Given it is a visually obscuring what is going on under the hood with the visuals. 

- Beware it attempts to connect to ports: `20, 21, 23, 25, 53, 67, 68, 69, 110, 119, 123, 143, 156, 161, 162, 179, 194, 389, 443, 587, 993, 995, 3000, 3306, 3389, 5060, 5900, 8000, 8080, 8888` **this could be considered as port scanning, which is illegal in some countries without explicit permission do not use blindly!** [ports.js](https://github.com/Lissy93/web-check/blob/master/api/ports.js)
- Beware contains [[NodeJS]] and the `npm`, there is a docker container consider forking [Dockerfile](https://github.com/Lissy93/web-check/blob/master/Dockerfile)

- Uses `localhost` not 127.0.0.1; consider modifying if this is an issue
	- `./public/resources/openapi-spec.yml:  - url: http://localhost:3001/api
	- `./public/resources/openapi-spec.yml:  - url: http://localhost:3000/api`
#### Usage

Run `docker run -p 3000:3000 lissy93/web-check`, then open [`localhost:3000`](http://localhost:3000). Consider forking [Dockerfile](https://github.com/Lissy93/web-check/blob/master/Dockerfile)

For some reason you allow `yarn` on your [[Kali]] or [[ParrotOS]] box:
```bash
# Download the code from GitHub
git clone https://github.com/Lissy93/web-check.git  
cd web-check
# Install the NPM dependencies
yarn install
# Build the app for production
yarn build
# Start the app (API and GUI)
yarn serve                                          
```

## References

[GitHub - web-check](https://github.com/Lissy93/web-check) 