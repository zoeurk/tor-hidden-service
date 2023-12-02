	Tor hidden service on a tmpfs filesystem  
  
Create a directory:  
	mkdir /var/opt/tor  
  
Add in fstab:  
	tmpfs /var/opt/tor/service tmpfs defaults,size=32M 0 0  
Mount it:
	mount /var/opt/service  
  
Add in apparmor.d/system_tor:  
	/var/opt/tor/** rw,  
	/var/opt/tor rw,  
  
Add in systemd tor\@default.service:  
	ExecStartPre=/usr/bin/install -Z -m 750 -o debian-tor -g debian-tor -d /var/opt/tor/service  
	ReadWriteDirectories=/var/opt/tor/  
  
Modify torrc:  
	HiddenServiceDir /var/opt/tor/service  
	HiddenServicePort 80 127.0.0.1:80  
	HiddenServicePort 8080 127.0.0.1:8080  
	HiddenServiceDirGroupReadable 1  

