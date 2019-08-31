# Setting up Rclone Mount

1. Download **WinFsp** and select all of the options during installation
2. Download the **nssm tool**
   * Extract this to your rclone folder and then cut/paste the 64 bit version into the actual rclone folder
3. Open CMD, but not as an Admin
    * Type `nssm install` to open the GUI - if this throws an error then change directories within CMD to the rclone folder that is holding the `nssm.exe` file
    * Type the following under Applications:
    * Path: `C:\path\to\rclone\rclone.exe`
    * Startup Directory: `C:\path\to\rclone`
    * Arguments: `mount gdcrypt: X: --config "C:\Users\**USERNAME**\.config\rclone\rclone.conf" --allow-other --buffer-size 1G --dir-cache-time 96h --log-level INFO --timeout 1h --user-agent rcloneapp`
    * Service Name: `rcloneMount`
    * Under Exit type: 10000 ms, Select the Restart application setting
4. You should now see a folder that says gdcrypt (X:) under your Windows Explorer. If not, type `nssm start rcloneMount`
5. Right click on the drive then Proprities -> Customise -> Optimize for: **Documents** (Aply for all sub folders)
