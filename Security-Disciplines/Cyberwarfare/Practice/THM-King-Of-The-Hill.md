Rules

To prevent cheating and ensure this game is realistic, everyone must the follow the rules:

1.  The machine should not be made unavailable (shutdown/reboot, firewall/iptables rules to stop all communication, all services terminated, machine botching etc).
2.  Only stop a service if it can't be patched any other way. Services should remain available for “genuine users of the box” if at all possible. Changing ports of services is allowed. (Try to keep the machines in as original state as possible.)
3.  No modifying/removing flags or their permissions (if any flag is everyone readable, it should be left like that).
4.  Do not attack, modify or stop the service(king/KoTH service) on 9999 (this includes a 'KoTH' binary placed by default in /root and things like changing service locations.)
5.  Any sort of DoS against the machine.
6.  No attacking other users (you have no reason to attempt any recon on any IP other than the one given to you on the game page).
7.  Scripts that automatically hack(autopwns) and/or harden the machine are forbidden.
8.  Do NOT delete system binaries (except chattr) or change executable permissions on them (or their directory).
9.  Using alt/dummy accounts to control resets is not allowed.
10.  Resets should only be used if the target has been broken or otherwise rendered unusable; resets shouldn't be used to prevent users from gaining access.
11.  If one vulnerability is patch then don't spam resets, there are 4-5 methods to gain foothold in every machine.

Additionally:
- You are allowed to use rootkits. But as implied by rules, while planting rootkits, make sure you do not break the machine or make it unusable for everyone but you.

Points - Points do not go towards your TryHackMe account score.

There are two ways to get points.

1.  `Be King` The longer you have your username in the /root/king.txt file, the more points you get. Every minute you're in there, you obtain 10 points.
2.  `Submit Flags` There are multiple different ways to compromise the machine, some will have hidden flags. Each flag is worth a different point amount, depending on the achievement difficulty.


## References

[THM guide to KOTH](https://tryhackme.com/resources/blog/guide-to-king-of-the-hill)