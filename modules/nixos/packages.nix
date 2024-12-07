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
      i3lock-fancy-rapid
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
      mpv-unwrapped
      qview
      peazip
      woeusb-ng
      font-awesome
      waypaper
      starship
      android-studio
      lazygit
      distrobox
      zoxide
      fuse
      appimage-run
      xdg-user-dirs
    ];

    # Fonts packages
    fonts.packages = with pkgs; [
      font-awesome
      nerd-fonts.droid-sans-mono
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

  # Plex media server
   services.plex = {
    enable = true;
    openFirewall = true;
    user="kleidis";
  };

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Enable the direnv package
  programs.direnv.enable = true;

  # JAVA
  programs.java = {
  enable = true;
  package = pkgs.jdk17; # Or pkgs.jdk21 depending on your preference
};

}
