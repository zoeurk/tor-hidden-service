	Tor hidden service on a tmpfs filesystem (ubuntu[/debian])
  
Create a directory:  
	&emsp;mkdir /var/opt/tor  
  
Add in fstab:  
	&emsp;tmpfs /var/opt/tor/service tmpfs defaults,size=32M 0 0  
Mount it:  
	&emsp;mount /var/opt/tor/service  
  
Add in apparmor.d/system_tor:  
	&emsp;/var/opt/tor/** rw,  
	&emsp;/var/opt/tor rw,  
  
Add in systemd tor\@&#65279;default.service:  
	&emsp;ExecStartPre=/usr/bin/install -Z -m 750 -o debian-tor -g debian-tor -d /var/opt/tor/service  
	&emsp;ReadWriteDirectories=/var/opt/tor/  
&ensp;Note: If you want to use /tmp, /home, ... (or something like this), you may have to modify PrivateTmp or ProtectHome.  
  
Modify torrc:  
	&emsp;HiddenServiceDir /var/opt/tor/service  
	&emsp;HiddenServicePort 80 127.0.0.1:80  
	&emsp;HiddenServicePort 8080 127.0.0.1:8080  
	&emsp;HiddenServiceDirGroupReadable 1  


