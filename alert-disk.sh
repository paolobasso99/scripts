#!/bin/bash
DIR=/home
CURRENT=$(df $DIR | grep $DIR | awk '{ print $5}' | sed 's/%//g')
PERCENTAGE=85
SERVER_NAME='Awesome server'
CHECK_URL=https://hc-ping.com/123456789
KEY=123456789
URL=https://example.com

if [ "$CURRENT" -gt "$PERCENTAGE" ] ; then
    curl -X POST -H "Content-Type: application/json" -d "{\"key\":\"$KEY\", \"title\":\"Disk alert $SERVER_NAME\", \"msg\":\"Your disk remaining free space is low. Used: $CURRENT%\"}" $URL
fi

# Check url
wget $CHECK_URL -O /dev/null