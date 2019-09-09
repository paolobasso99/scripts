#!/bin/bash
CHECK_FILE=/mnt/cloud/test.txt
SERVER_NAME='Awesome server'
MOUNT_NAME='Google Drive'
CHECK_URL=https://hc-ping.com/123456789
KEY=123456789
URL=https://example.com

# Run
DATE=$(date +"%d %B %Y, %H:%M:%S")
if [[ ! -f $CHECK_FILE ]]; then
    echo "RESULT: Mount error!"
    curl -X POST -H "Content-Type: application/json" -d "{\"key\":\"$KEY\", \"title\":\"$MOUNT_NAME mount error ($SERVER_NAME)\", \"msg\":\"$MOUNT_NAME is not mounted correctly in $SERVER_NAME at $DATE\"}" $URL
else
    echo "RESULT: Mount works!"
fi


# Check url
wget $CHECK_URL -O /dev/null
