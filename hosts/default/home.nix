{ config, pkgs, ... }:


{
  imports = [
    ../../modules/config/alacritty.nix #Alacirty config
    ../../modules/config/bash.nix #Bash config
    ../../modules/config/awesome.nix #Awesome config
    ../../modules/config/polybar.nix #Polybar config
    ../../modules/config/rofi.nix #Rofi config
    ../../modules/config/picom.nix #Picom config
    ../../modules/config/themes.nix #Themes config
    ../../modules/config/dunst.nix #Dunst config
  ];

  # Do not touch this otheriwse your login will not work
  services.pass-secret-service = {
    enable = true;
    package = pkgs.libsecret;
  };

  # Declare the user
  home.username = "kleidis";
  home.homeDirectory = "/home/kleidis";
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # QT
  qt.style.name = "kvantum";
  qt.platformTheme.name = "kvantum";

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {};

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}