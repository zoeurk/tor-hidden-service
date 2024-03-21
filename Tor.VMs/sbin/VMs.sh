#!/bin/dash
until -e /tmp/connected/connected
do
	sleep 1
done
. /opt/VMs/vm-tor-relay.src
. /opt/VMs/vm-tor-exit.src
