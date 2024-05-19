# Android

**Beware methods and tools used in this page will almost certainly void any warranty you have for your device**


## Termux

Install Git and Configure Termux and Android File system from [Alan C. Bonnici - Medium](https://chribonn.medium.com/how-to-clone-and-synchronise-a-github-repository-on-android-a59ddf7cd092)
```bash
# The blog referenced mentions actually using GitHub on Phone, each to there own doing a activity in a specific place and device works for me, I just want re-re-re-read Question Based methodologies before I sleep till I get good some day...
# There is alot of Malware on Github...permissions
apt update  
apt upgrade
pkg install git  
# If you really want to push to Github on your phone
git config --global user.name "<name>"   
git config --global user.email "<email>"
termux-setup-storage
```


## Flashing Firmware

**BEWARE** some devices are not support - [[RTFM]], do the work, do not spray and pray!

- Requires Windows or Chrome
	- [Odin](https://odindownload.com/SamsungOdin/)  - requires Windows
	- [Android Flash Tool](https://flash.android.com/welcome) - requires Chrome
- Desired Firmware downloaded from [Samsung Firmware Science website](https://samsung.firmware.science) or custom stuff if that is what you want, if you do not know go with legitimate vendors that you can verify 
	- *For any older Samsung device, the best place to look is typically in the [corresponding XDA forum](https://forum.xda-developers.com).*
## References

[Odin](https://odindownload.com/SamsungOdin/)
[Android Flash Tool](https://flash.android.com/welcome) 
[Samsung Firmware Science website](https://samsung.firmware.science)
[XDA forum](https://forum.xda-developers.com)
[android.gadgethacks.com](https://android.gadgethacks.com/how-to/use-odin-flash-samsung-galaxy-stock-firmware-0182037/)
[Alan C. Bonnici - Medium](https://chribonn.medium.com/how-to-clone-and-synchronise-a-github-repository-on-android-a59ddf7cd092)