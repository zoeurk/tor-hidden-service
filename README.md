##	Tor hidden service on a tmpfs filesystem (ubuntu[/debian])
  
### Working Directory
Create a directory:  
	&ensp;mkdir /var/opt/tor  
	&ensp;chmod 750 /var/opt/tor  
  
### Hidden Service Directory
Add in fstab:  
	&ensp;tmpfs /var/opt/tor/service tmpfs defaults,size=32M 0 0  
Mount it:  
	&ensp;mount /var/opt/tor/service  
  
### Apparmor
Add in apparmor.d/system_tor:  
	&ensp;/var/opt/tor/** rw,  
	&ensp;/var/opt/tor rw,  
  
### Systemd Service
Add in systemd tor\@&#65279;default.service:  
	&ensp;ExecStartPre=/usr/bin/install -Z -m 750 -o debian-tor -g debian-tor -d /var/opt/tor/service  
	&ensp;ReadWriteDirectories=/var/opt/tor/  
**Note:** *If you want to use /tmp, /home, or something like this, you may have to modify* **PrivateTmp** *or* **ProtectHome***.*  
  
### The Hidden Service Itself
Modify torrc:  
	&ensp;HiddenServiceDir /var/opt/tor/service  
	&ensp;HiddenServicePort 80 127.0.0.1:80  
	&ensp;HiddenServicePort 8080 127.0.0.1:8080  
	&ensp;HiddenServiceDirGroupReadable 1  


