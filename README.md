##	Tor hidden service on a tmpfs filesystem (ubuntu[/debian])
  
### Introduction
Here, I show how to create an hidden service in the directory "_/var/opt/tor_".  
From this tutorial you can create an hidden service outside the directory "_/var/lib/tor/_".  

### Working Directory
Create a directory:  
	&emsp;mkdir -m 750 /var/opt/tor  
  
### Hidden Service Directory
Add in fstab:  
	&emsp;tmpfs /var/opt/tor/service tmpfs defaults,size=32M 0 0  
  
### Apparmor
Add in apparmor.d/system_tor:  
	&emsp;/var/opt/tor/** rw,  
	&emsp;/var/opt/tor rw,  
  
### Systemd Service
Add in tor@&#65279;default.service (/usr/lib/systemd/system/):  
	&emsp;ExecStartPre=/usr/bin/install -Z -m 750 -o debian-tor -g debian-tor -d /var/opt/tor/service  
	&emsp;ReadWriteDirectories=-/var/opt/tor/  
**Note:** *If you want to use* **/tmp**_,_ **/home**_,_ *or something like this, you may have to modify* **PrivateTmp** *or* **ProtectHome**_._  
  
### The Hidden Service Itself
Modify torrc:  
	&emsp;HiddenServiceDir /var/opt/tor/service  
	&emsp;HiddenServicePort 80 127.0.0.1:80  
	&emsp;HiddenServiceDirGroupReadable 1 #**add this line after hidden services declaration.**  

### At Last
Runs these commands:  
	&emsp;systemctl daemon-reload  
	&emsp;mount /var/opt/tor/service  
	&emsp;systemctl restart apparmor  
	&emsp;systemctl restart tor _(or tor@default)_
### So for tor...
Now you are not just able to create an hidden service outside "_/var/lib/tor/_".  
In fact:  
	&emsp;If you have understand how to configure **tor** (through _torrc_ for exemple), **apparmor** and **systemd**,  
you can create differents instance of **_tor_** at boot time.

### End now
If you create differents instance of **tor**,  
you may(/can) also want to play with your firewall and virtual network interface.  
For exemple you can do somthing like this:  
	&emsp;ORPort 443 NoListen  
	&emsp;ORPort 9090 NoAdvertise  
You need to do a Network Address Translation (**NAT**):  
	&emsp;443 -> 9090

### Play With Tor
Be enjoy with some virtuals machines :))  
See in Tor.VMs directory

### No Goal
With VMs and Tor you can learn about: _virtual network interface_, _dhcp_, and why not _DNS_ (maybe more but I dont see)  
Tor is very good for learning.  
  
Enjoy with Tor :)

