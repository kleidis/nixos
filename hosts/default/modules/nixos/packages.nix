{ config, pkgs, inputs, ... }:

{
  # You mostly want to install packages through here
  environment.systemPackages = with pkgs; [
      git
      vscode
      fastfetch
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
      power-profiles-daemon
      gnome-disk-utility
      brightnessctl
      upower
      gvfs
      xdg-user-dirs
      blueman
      bluez
      eza
      kdePackages.qt6ct
      libsForQt5.qt5ct
      libnotify
      udiskie
      pamixer
      playerctl
      pavucontrol
      lxde.lxrandr
      rofi
      font-awesome
      waypaper
      starship
      zoxide
      fuse
      appimage-run
      nerdfonts
    ];

    # Fonts packages
    fonts.packages = with pkgs; [
      font-awesome
      nerdfonts
    ];
}