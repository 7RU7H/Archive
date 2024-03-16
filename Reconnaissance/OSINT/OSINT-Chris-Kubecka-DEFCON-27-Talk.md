# [[OSINT]] Chris Kubecka DEFCON 27 Talk


[Chris Kubecka - Hack the World and Galaxy with OSINT - DEF CON 27 ICS Village](https://www.youtube.com/watch?v=MMFIGJ8__ak) 

[Chris Kubecka](https://en.wikipedia.org/wiki/Chris_Kubecka) has a fascinating Wikipedia page:
- Once a ten year old Wardialer ([Wikipedia - Wardialing](https://en.wikipedia.org/wiki/Wardialing))
- Headed Aramco Overseas Security Operations, Information Protection & Intelligence
- U.S Air  Force Space Command & Military Aviator C-5 Loadmaster 

She is also a meme goddess:
![](chriskubecka-ismemegoddess.png)
[https://www.researchgate.net -Chris Kubecka Hack the World with OSINT 2019 PDF](https://www.researchgate.net/publication/332875854_Hack_the_World_with_OSINT)

This talk is about [[Hacking-ICS]] (Industrial Control Systems) and its impact. It discusses the current and future concerns of independence, automation and security bad practices and flaws in business to business operational requirements that lead to exposed infrastructure, which can be leverage by malicious actors. Long term installation entailing a lot legacy systems in non-human reachable environments that require remote access, which are part of backbone of nation states and businesses.  
#### Security And Privacy Challenges

CryptoMiners, Ransomware, Data breaches 
- Large number of access points
- Renewable energy systems entry points
- Electricity theft
- Most equipment privately owned
- Lacking standardisation
- Security an afterthought
- Bolt on security
- Move fast and break things, make money and cash out mentality 

#### Critical Infrastructure

- Power Plants
- Water Systems
- Agriculture
- Hydroelectric Dam
- Railway
- Logistics
- Weed - Apparently

Pictures speak a thousand words about open systems:

Chinese open systems:
![](chriskubecka-openchinesesystems.png)

European open systems
![](chriskubecka-openeuropeansystems.png)

These are often remote systems connected to radio, WIFI, etc generally manufacture requires remote access as part a warrantee and that tends to then entail [[VNC]] with no authentication or reused credentials across their customer base.

Sometimes these ICS use [[Modbus]] - [Wikipedia - Modbus](https://en.wikipedia.org/wiki/Modbus), which is a unencrypted TCP Application Layer communication protocol that can accept raw unauthenticated hex.  


Logistics Systems with weak security are used in smuggling by a bad actors altering cargo manifests.
![](chriskubecka-logisticshack.png)

Salmon farm is automated in Norway and large part of GDP
![](chriskubecka-salmonfarm.png)

Chris Kubecka is also a GCHQ certified instructor and in the last part of a NATO Cyberware scenario and simulation of a cyber attack against the London Underground with the bad actor causing a train-on-train collision.
![](chriskubecka-gchqandtheunderground.png)
There are a lot of remote legacy systems are can be troublesome while being critically important.

Weed farming has automated systems that is major part of GPD.
![](chriskubecka-weedismoneymaking.png)

Solar and Wind
- Crucial for the Paris Accord
- Load management
- Climate change
- Many vendors
- Not much security testing

`metadata.device_type: "solar panel"`

If you can get into the system you can perform Electricity Dumping - not feeding the electricity to the system. The concerning being a mass blackout of power required for other infrastructure. When doing another exercise for GCHQ they found about 80% of the wind turbines were using default credentials found in manuals... [[RTFM]]

These Turbines are also attached to other [[Network-Protocols]] and therefore other networks and assets:
![](chriskubecka-protocolattachedtowindturbines.png)

#### Smart Electric Meters

- Mandatory in some EU countries
- Mandatory in some US areas
- Privacy concerns 
	- Can be refused in Netherlands
- Security concerns
- No cyber security testing requirements

[[Search-Engine-Dorking]]: `80.http.get.title: <metermanufacture>` - it is  really difficult to see what the last part is so this might be incorrect.

#### Open Automated Demand Response

- North America
- Interoperability management
- Pricing
- Demand
- Controls all components
- Zero Security

Attach system's protocols
![](chriskubecka-openautomateddemandresponse-attachsystems.png)

#### Aviation 

Sheremetyevo international Airport flight controller system is connected to the internet with SMBv1... many of these systems are very long. [Paris Orly Airport](https://en.wikipedia.org/wiki/Orly_Airport) (in 2019) is run on one XP "metal box", it was retired into 2020 because the one person that provides maintenance it retired. When it goes down it causes chaos in the skies in Europe.  
- Airports (civilian and military)
- Intertravel systems
- Ticketing Systems
- Datahub

#### US Aircraft Manufacturer

- No current coordinated disclosure program
- Exposure of entire test & development
- Some poor coding practices
- Some poor digital security

#### Maritime 

- Automatic Identifications System
- GPS based ship controls
- [Ku Band](https://en.wikipedia.org/wiki/Ku_band) *"is the portion of the [electromagnetic spectrum](https://en.wikipedia.org/wiki/Electromagnetic_spectrum "Electromagnetic spectrum") in the [microwave](https://en.wikipedia.org/wiki/Microwave "Microwave") range of frequencies from 12 to 18 [gigahertz](https://en.wikipedia.org/wiki/Gigahertz "Gigahertz") (GHz)."*
- [Ka Band](https://en.wikipedia.org/wiki/Ka_band) *"(pronounced as either "kay-ay band" or "ka band") is a portion of the [microwave](https://en.wikipedia.org/wiki/Microwave "Microwave") part of the [electromagnetic spectrum](https://en.wikipedia.org/wiki/Electromagnetic_spectrum "Electromagnetic spectrum") defined as [frequencies](https://en.wikipedia.org/wiki/Frequency "Frequency") in the range 26.5–40 [gigahertz](https://en.wikipedia.org/wiki/Gigahertz "Gigahertz") (GHz)"*
- Industrial 4G
- Sight-to-sight WIFI
- Windows CE/XP/7 based IIOT

#### Houses

- Smart Houses
- Washing machines
- Fridges
- IOT devices
#### Space Asset Challenges 

- Legacy equipment
- Interoperability
- IOT
- Lack of Encryption
- Nation-state Attacks
- Solar Weather
- Radiation flipping bits
- Surveillance
- Manipulation
- Debris
- Loss of visibility
- Low cost uncontrolled launches





Another amazing meme
![](chriskubecka-ismemegoddess-part2.png)
## References

[Wikipedia - Modbus](https://en.wikipedia.org/wiki/Modbus)
[Wikipedia - Wardialing](https://en.wikipedia.org/wiki/Wardialing)
[Chris Kubecka - Hack the World and Galaxy with OSINT - DEF CON 27 ICS Village](https://www.youtube.com/watch?v=MMFIGJ8__ak) 
[Wikipedia - Chris Kubecka](https://en.wikipedia.org/wiki/Chris_Kubecka) 
[https://www.researchgate.net -Chris Kubecka Hack the World with OSINT 2019 PDF](https://www.researchgate.net/publication/332875854_Hack_the_World_with_OSINT)
[Wikipedia Ku Band](https://en.wikipedia.org/wiki/Ku_band) 
[Wikipedia Ka Band](https://en.wikipedia.org/wiki/Ka_band) 