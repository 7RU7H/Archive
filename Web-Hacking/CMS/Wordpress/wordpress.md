# Wordpress 

## Introduction
[Free 25 API requests per day](https://wpscan.com/pricing)

## What to look for
/wp-config/

## WPscan

```bash
wpscan --url -e --api-token $APIKEY # -o filename
```

```bash
# optional - all plugins, themes, plus timthumbs
# vp,vt,tt,cb,dbe,u,m
ap at t tt dbe u m cb
```

## Nmap 