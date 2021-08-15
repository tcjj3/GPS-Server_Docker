#!/bin/sh






#[ -z "$DEVICE" ] && DEVICE="/dev/ttyUSB0"


killall gpsd
#gpsd /dev/ttyUSB0 -F /var/run/gpsd.sock -G
#gpsd /dev/ttyUSB0 -F /var/run/gpsd.sock -P /run/gpsd/gpsd.pid -G
if [ ! -z "$DEVICE" ]; then
gpsd ${DEVICE} -F /var/run/gpsd.sock -P /run/gpsd/gpsd.pid -G
else
gpsd -F /var/run/gpsd.sock -P /run/gpsd/gpsd.pid -G
fi
#service gpsd start


RUNASUSER="ntp"
#service ntp start
UGID="$(getent passwd $RUNASUSER | cut -f 3,4 -d:)"
if [ ! -z "$UGID" ]; then
#ntpd -p /var/run/ntpd.pid -g -u $UGID
ntpd -n -p /var/run/ntpd.pid -g -u $UGID
else
#ntpd -p /var/run/ntpd.pid -g
ntpd -n -p /var/run/ntpd.pid -g
fi









exit 0







