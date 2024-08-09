{ config, pkgs, inpus, ... }:

{
# Enable the X11 windowing system.
  services.xserver.enable = true;

# Desktop Evoirments / Wms
  services.xserver.desktopManager.cinnamon.enable = false;
  services.xserver.windowManager.awesome.enable = true;

  # Touchpad support for X11
  services.xserver.libinput.enable = true;

  # Set awesome as the default session
  services.xserver.displayManager.defaultSession = "none+awesome";
  # Xinit commands
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xrdb}/bin/xrdb -merge <<EOF
    Xft.dpi: 125
    EOF
    waypaper --restore &
    systemctl --user --now start AutostartApps
  '';

  # Greenclip for rofi
  services.greenclip.enable = true;

 # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # High DPI for x11
  services.xserver.dpi = 125;
}