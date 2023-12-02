	Tor hidden service on a tmpfs filesystem (ubuntu[/debian])
  
Create a directory:  
	&ensp;mkdir /var/opt/tor  
  
Add in fstab:  
	&ensp;tmpfs /var/opt/tor/service tmpfs defaults,size=32M 0 0  
Mount it:  
	&ensp;mount /var/opt/service  
  
Add in apparmor.d/system_tor:  
	&ensp;/var/opt/tor/** rw,  
	&ensp;/var/opt/tor rw,  
  
Add in systemd tor\@&#65279;default.service:  
	&ensp;ExecStartPre=/usr/bin/install -Z -m 750 -o debian-tor -g debian-tor -d /var/opt/tor/service  
	&ensp;ReadWriteDirectories=/var/opt/tor/  
  
Modify torrc:  
	&ensp;HiddenServiceDir /var/opt/tor/service  
	&ensp;HiddenServicePort 80 127.0.0.1:80  
	&ensp;HiddenServicePort 8080 127.0.0.1:8080  
	&ensp;HiddenServiceDirGroupReadable 1  

