#!/bin/bash

##############################################################################
# An rclone backup script by Jared Males (jaredmales@gmail.com)
#
# Copyright (C) 2018 Jared Males <jaredmales@gmail.com>
#
# This script is licensed under the terms of the MIT license.
# https://opensource.org/licenses/MIT
#
# Runs the 'rclone copy' command.  Designed to be used as a cron job.
#
# 1) Backup Source
#    Edit the SRC variable below to point to the directory you want to backup.
#
# 2) Backup Destination
#    Edit the DEST variable to point to the remote and location (see rclone docs).
#
# 3) Excluding files and directories
#    Edit the EXCLUDEFILE variable below to point to a file listing files and directories to exclude.
#    See the rclone docs for the format.
#
#    Also, any directory can be excluded by adding an '.rcloneignore' file to it without editing the exclude file.
#    This file can be empty.  You can edit the name of this file with EXIFPRESENT below.
#
# 4) Logs:
#    -- The output of rclone is written to the location specified by LOGFILE.  This is rotated with savelog.
#       The details of log can be edited.
#    -- The log rotation, and start and stop times of this script, are written to the location specified by CRONLOG.
#       This isn't yet rotated, probably should be based on size.
#
##############################################################################

#### options

# healthchecks.io
HEALTHCHECKS=""

#---- This folder will contain logs and the exclude file
RCLONEDIR=/home/user/rclone

#---- The name of this script
SCRIPTNAME=rclone-cron.sh

#---- Edit this to the source
SRC=/home/user/data

#---- Edit this to the desired destination
DEST=dest:path

#---- This is the path to a file with a list of exclude rules
EXCLUDEFILE=$RCLONEDIR/excludes

#---- Name of exclude file
# NOTE: you need "v1.39-036-g2030dc13β" or later for this to work.
EXIFPRESENT=.rcloneignore

#---- The bandwidth time table
BWLIMIT="08:00,512 00:00,off"

#---- Ignore brand new stuff, possible partials, etc.
MINAGE=15m

#---- [B2 Specific] number of transfers to do in parallel.  rclone docs say 32 is recommended for B2.
TRANSFERS=32

#---- Location of rclone log [will be rotated with savelog]
LOGFILE=$RCLONEDIR/rclone.log
LOGS='-vv --log-file='$LOGFILE

#---- Location of cron log
CRONLOG=$RCLONEDIR/rclone-cron.log

### Clone!

#Rotate logs.
savelog -n -c 7 $LOGFILE >> $CRONLOG

#Log startup
echo $(date -u)' | starting $SCRIPTNAME . . .' >> $CRONLOG

# Exit if another rclone job already exist
if pidof -o %PPID -x “$SCRIPTNAME”; then
    # Log
    echo $(date -u)' | another rclone job already exist, exit.' >> $CRONLOG

    # Ping healthchecks.io
    wget $HEALTHCHECKS -O /dev/null

    exit 1
fi

#Now do the copy!
rclone copy --dry-run $SRC $DEST --transfers $TRANSFERS --min-age $MINAGE --exclude-from $EXCLUDEFILE --exclude-if-present $EXIFPRESENT --delete-excluded $LOGS

#log success
echo $(date -u)' | completed $SCRIPTNAME' >> $CRONLOG

# Ping healthchecks.io
wget $HEALTHCHECKS -O /dev/null

exit
