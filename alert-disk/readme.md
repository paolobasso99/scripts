# Alert disk
A simple python script to check and notify me whether a disk is almost full.

# Requisites
For the notifications this app uses my [personal-notifications](https://github.com/paolobasso99/personal-notifications) service that has to be hosted on a server. Check the [personal-notifications page](https://github.com/paolobasso99/personal-notifications) in order to configure it.

## Setup
1. install python 3.8 or above on the host machine
2. edit the envirorment variables inside the script
3. setup a crontab as follow: `0 */3 * * * /srv/scripts/alert-disk.py`

