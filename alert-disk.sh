#!/bin/bash
MAIL=mailid@domainname.com
DIR=/home
CURRENT=$(df $DIR | grep $DIR | awk '{ print $5}' | sed 's/%//g')
PERCENTAGE=85
SERVER_NAME='Awesome server'
CHECK_URL=https://hc-ping.com/123456789

if [ "$CURRENT" -gt "$PERCENTAGE" ] ; then
    echo Your disk remaining free space is low. Used: $CURRENT% | mail -s 'Disk Space Alert for $SERVER_NAME' $MAIL
fi

# Check url
wget $CHECK_URL -O /dev/null