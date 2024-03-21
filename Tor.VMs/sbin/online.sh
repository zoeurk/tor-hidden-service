#!/bin/dash
test -d /tmp/connected && rm -rf /tmp/connected
mkdir /tmp/connected
until ping -i 1 -c 1 -w 1 -W 1 -q $1 > /dev/null;
do
	sleep 1;
done
touch /tmp/connected/connected.ok
