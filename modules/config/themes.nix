{config, inputs, ...}: {
  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      flavor = "mocha";
      accent = "red";
      size = "standard";
      tweaks = [ "normal" ];
      icon = {
        enable = true;
        flavor = "mocha";
      };
    };
  };
    xdg.configFile = {
      "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    };

  qt = {
    enable = true;
    style = {
      catppuccin = {
        enable = true;
        flavor = "mocha";
        accent = "red";
      };
    };
  };
  programs = {
    alacritty= {
      catppuccin  = {
        enable = true;
      };
    };
  };

}