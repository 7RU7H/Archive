# Systemd Controversies


This is the authors attempt to understand something sort of *political* in regard to Linux and System Administration. It contains none of my opinions, just what I found regarding the controversies of `systemd`, references are provided with data as they are just mirrors.


https://pwnies.com/systemd-bugs/
[5998](https://github.com/systemd/systemd/issues/5998), [6225](https://github.com/systemd/systemd/issues/6225), [6214](https://github.com/systemd/systemd/issues/6214), [5144](https://github.com/systemd/systemd/issues/5144), [6237](https://github.com/systemd/systemd/issues/6237)
>Where you are dereferencing null pointers, or writing out of bounds, or not supporting fully qualified domain names, or giving root privileges to any user whose name begins with a number, there’s no chance that the CVE number will referenced in either the change log or the commit message. But CVEs aren’t really our currency any more, and only the lamest of vendors gets a Pwnie!


Mirror from from - https://www.reddit.com/r/linux/comments/5n069y/why_do_people_not_like_systemd/?sort=top, from suspend account https://www.reddit.com/user/jij_je_walkman_terug/
```
Faster start time than what? Not really than most other modern things. Better logging? The binary logging is a criticism a lot of people have, it provides faster indexing but binary logs are more easily corrupted and that's in general what people dislike. Log corruption has been witnessed more than once in the wild with systemd. In any case, here are some of the arguments you see going around:

# technical

- systemd appropriates the cgroup tree and takes control of it and completely messes with any other user of the cgroup tree and really wants them all to go through systemd, systemd was wirtten basically on the assumption that nothing but systemd would be using cgroups and they even tried to lobby to make cgroups a private prioperty of systemd in the kernel but that went no-where.
    
- systemd's usage of cgroups for process tracking is a fundamentally broken concept, cgroups were never meant for this and it's a good way to fuck resource usage up
    
- systemd has a hard dependency on glibc for really no good reason
    
- systemd relies on DBus for IPC, as the name 'Desktop bus' implies DBus was never written with this in mind and it shows. DBus was written to facilitate IPC within a single desktop session, not as a transport during early boot. This is why systemd wanted to push kdbus heavily beause kdbus solved some of the problems inherent to DBus being used as IPC during early boot.
    
- systemd's security and general code quality practices are less than stellar, a lot of security bugs pop up in systemd due to its insistence of putting quite a bit of code in pid1 and quickly adding new features and quickly changing things.
    

# political

- systemd creates dependencies and is a dependency of things for political reasons in order to encourage people to pick these things. This is not conjecture, Lennart has admitted multiple times that he creates dependencies to 'gently push' everyone to the same configuration
    
- systemd is monolithic for its own sake. It's basically product tying to encourage people to pick an all-or-none deal to again gently push towards this consistency
    

# personal

- Lennart Poettering, the face of systemd and its lead dev is the biggest primadonna FOSS has ever known who continues to shift blame and demand that entire world adapt to his designs.
    

Edit: I'll say that really only the political and personal matter though, systemd has its technical flaws and a of of things it did technically better than other things before it. The real anger against systemd is that it's inflexible by design because it wants to combat fragmentation, it wants to exist in the same way everywhere to do that. The people that dislike systemd are mostly the people that wanted to choose, and systemd takes this away with Lennart's primadonna attitude typically coming down to 'You shouldn't be caring about no longer being able to do this, because I don't care about it'. systemd is middle-of-the-road, the people who either want a hyper secure, or hyper small or hyper fast system are left out. The truth of the matter is that it barely changes anything because systemd has only been adopted by systems who never catered to those people anyway. It's mostly been adopted by systems who cater to people who don't really care about 'under the hood' as long as their desktop environment keeps running.

I'll also list a couple of technical things which systemd does right for completeness sake. (there is nothing political or personal I can find right with systemd):

- systemd popularized/invented the idea of basically abandoning `/tmp` in favour of `/run/user/$UID`, a different tmp directory for each user which is must better, world-shared temp directories have always been a disaster
    
- while launchd invented this, systemd is the first to bring launchd-style socket activation to Linux opposed to the older inferior inetd-style socket activation.
    
- systemd is one of the first systems I'm seeing do activation _almost_ right. That the activator itself is a unit in the case of socket which must be started is the way to go opposed to how inetd, launchd and DBus do their activation. A socket activated service `foo.service` can only be activated if `foo.socket` is started. This means that a service can still now depend on `foo.socket` being started and that you can easily make a service nonactivatable by stopping `foo.socket`
    
- systemd properly generalizes the concept of the 'service' and realize that it's all about dependencies, so it treats mounts, sockets, and whatever else as services as well and calls these 'units' which all have dependencies of their own
    
- systemd puts upstream config files in `/usr/lib/systemd` and local ones in `/etc/systemd`, a very sound idea to keep a distinction between config files upstream/your distro provides which you shouldn't modify and local ones which override these.
```