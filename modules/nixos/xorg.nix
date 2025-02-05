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
    EOF
    xrandr --output eDP --off \
          --output HDMI-A-0 --primary --mode 1920x1080 --rate 239.96 --pos 0x0 --rotate normal
    waypaper --restore &
    systemctl --user --now start AutostartApps
  '';

  services.xserver.deviceSection = ''
  Option "TearFree" "True"
  Option "VariableRefresh" "True"
'';

  # Greenclip for rofi
  services.greenclip.enable = true;

 # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
}