##	Tor hidden service on a tmpfs filesystem (ubuntu[/debian])
  
### Introduction
Here, I show how to create an hidden service in a directory named /var/opt/tor.  
From this tutorial you can create an hidden service the directory /var/lib/tor.  

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
	&emsp;HiddenServiceDirGroupReadable 1  

### At Last
Runs these commands:  
	&emsp;systemctl daemon-reload  
	&emsp;mount /var/opt/tor/service  
	&emsp;systemctl restart apparmor  
	&emsp;systemctl restart tor

