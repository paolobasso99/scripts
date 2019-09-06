@echo off
title \Mount rclone on Windows!
echo Mount rclone on Windows!
echo Mounting, please wait...

:: Get configs
for /f "delims=" %%x in (config.txt) do (set "%%x")

cmd /c rclone mount %SRC% %DEST% --config "%RCLONE_CONFIG_PATH%" --allow-other --buffer-size 1G --dir-cache-time 96h --log-level INFO --user-agent rcloneapp --fast-list --vfs-read-chunk-size 32M --vfs-read-chunk-size-limit off --vfs-cache-mode writes --stats 1m
