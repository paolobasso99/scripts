SRC=gdcache:
DST=/home/puser/mediabox/gd
LOG_DIR=/home/puser/logs

rclone mount $SRC $DST --allow-other --buffer-size 512M --dir-cache-time 96h --log-level INFO --log-file $LOG_DIR/rclone.log --timeout 1h --umask 002 --rc --read-only
/usr/bin/rclone mount gdcache: /home/puser/mediabox/gd --allow-other --buffer-size 512M --dir-cache-time 96h --log-level INFO --log-file /home/puser/logs/rclone.log --timeout 1h --umask 002 --rc --read-only