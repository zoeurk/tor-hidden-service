#!/bin/sh
TOR1="config1"
TOR2="config2"
TOR3="config3"
TOR_DIR=/etc/tor
TOR_ROTATE_CNF=/etc/logrotate.d/tor
CNF_FILES_WHERE_EXCLUDE="$TOR1 $TOR2 $TOR3"
SETS_LOGS_FILES="$CNF_FILES_WHERE_EXCLUDE"
CURRENT_DIR=`pwd`
which logrotate > /dev/null || \
	(
		printf "logrotate don't exist\n"
		exit
	)
if test ! -e $TOR_ROTATE_CNF
then
	printf "Error: $TOR_ROTATE_CNF don't exist\n"
	exit
fi
if test ! -d $TOR_DIR
then
	printf "Error: $TOR_DIR don't exist\n"
	exit
fi
test -d $TOR_DIR/tor-tool || mkdir $TOR_DIR/tor-tool
cd $TOR_DIR/tor-tool
if test "$1" = "-i"
then
	OPT="-i"
	DIR=`mktemp -d --suffix=.tor -p /root/`
	printf "Saving current config in: $DIR\n"
	cp -vr $TOR_DIR/* $DIR
fi
test -d tor || mkdir tor
for SETS in $SETS_LOGS_FILES
do
	sed -n '/ Guard / { s/^.*($\([0-9A-Z]*\)).*$/\1/p }' /var/log/tor/notices-${SETS}.log | sort | uniq > tor/${SETS}.txt
done
for file in tor/*.txt
do
	sed ':start;$ ! N; s/\n/,/;t start; s/^/ExcludeNodes /' $file > $file.nodes
done
for file in $CNF_FILES_WHERE_EXCLUDE
do
	if [ -s tor/${file}.txt.nodes ]
	then
		NODES="$(sed 's/ExcludeNodes /,/' tor/${file}.txt.nodes)"
		sed -e "/^ExcludeNodes/ { s/$/$NODES/ }" -e "$ { s/$/\nExcludeNodes $NODES/; s/ExcludeNodes *,/ExcludeNodes / }" $OPT ../tor-${file}.rc
		sed '/^ExcludeNodes/ { $ { q 1 } }; /^ExcludeNodes/ q 0' ../tor-${file}.rc >/dev/null && sed '$ d' $OPT ../tor-${file}.rc
	fi
done
if test "$OPT" = "-i"
then
	logrotate -f /etc/logrotate.d/tor
	printf "You need to restart, reload... tor\n"
fi
cd $CURRENT_DIR
