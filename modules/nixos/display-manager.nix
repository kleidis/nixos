  { config, pkgs, inpus, ... }:

{
  # Display manager (Used for login)

  # Set sddm as the display manager and awesome as the default session
  services.displayManager.sddm.package = pkgs.pkgs.kdePackages.sddm;
  services.displayManager.sddm.enable = true;
  # SDDM catppuccin theme
  services.displayManager.sddm.catppuccin.enable = true;
  # Enable gnome keyring for sddm
  security.pam.services.sddm.enableGnomeKeyring = true;
}