#!/bin/dash
until ping -i 1 -c 1 -w 1 -W 1 -q $1 > /dev/null;
do
	sleep 1;
done
