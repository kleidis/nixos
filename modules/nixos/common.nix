{ config, pkgs, inpus, ... }:

{
# Thumbnail service for thunar
  services.tumbler.enable = true;
# Enable if you use thunar so the settigns do not reset
  programs.xfconf.enable = true;
# GVFS for mounting file systems such as phones
  services.gvfs.enable = true;

# Set your time zone.
  time.timeZone = "Europe/Tirane";

# Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true; # Service

# Autologin
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "kleidis";

# Power Management
  services.power-profiles-daemon.enable = true;

# NTFS file system support (For Windows Partitions)
  boot.supportedFilesystems = [ "ntfs" ];
}