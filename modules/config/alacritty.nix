{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "DroidSansM Nerd Font";
          style = "Regular";
        };
        size = 12.0;
      };

      window = {
        opacity = 1.0;
        padding = {
          x = 15;
          y = 15;
        };
      };
    };
  };

  # Generate the Catppuccin Mocha theme file in the user's home directory
  home.file = {
    ".config/xfce4/helpers.rc" = {
      text = ''
        TerminalEmulator=alacritty
        TerminalEmulatorDismissed=true
        X-XFCE-CommandsWithParameter=alacritty -e "%s"
      '';
    };
  };

}