## Introduction

You can use tools like [[FFUF-Cheatsheet]] or [[Gobuster-Cheatsheet]]

## wfuzz
`wfuzz -c -u http://dns.name -H "Host:FUZZ.dns.name" -w /usr/share/seclists/Discovery/DNS/* --hw 977`