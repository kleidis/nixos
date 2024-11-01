{ config, pkgs, inputs, ... }:


{
  # You mostly want to install packages through here


  environment.systemPackages = with pkgs; [
      git
      vscode
      fastfetch
      brave
      copyq
      feh
      (discord.override {
        withVencord = true;
      })
      awesome
      gh
      libsecret
      github-desktop
      polybarFull
      polybar-pulseaudio-control
      libsForQt5.qtstyleplugin-kvantum
      xfce.thunar
      picom
      flameshot
      dconf
      xclip
      alacritty
      pfetch-rs
      pciutils
      looking-glass-client
      power-profiles-daemon
      gnome-disk-utility
      brightnessctl
      upower
      gvfs
      xdg-user-dirs
      blueman
      bluez
      eza
      remmina
      kdePackages.qt6ct
      libsForQt5.qt5ct
      libnotify
      udiskie
      pamixer
      playerctl
      pavucontrol
      arandr
      rofi
      font-awesome
      waypaper
      starship
      zoxide
      fuse
      appimage-run
      nerdfonts
      xdg-user-dirs
    ];

    # Fonts packages
    fonts.packages = with pkgs; [
      font-awesome
      nerdfonts
    ];

    programs.spicetify =
   let
     spicePkgs = inputs.spicetify.legacyPackages.${pkgs.system};
   in
   {
     enable = true;
     enabledExtensions = with spicePkgs.extensions; [
       adblock
       hidePodcasts
       shuffle # shuffle+ (special characters are sanitized out of extension names)
     ];
     theme = spicePkgs.themes.catppuccin;
     colorScheme = "mocha";
   };
}