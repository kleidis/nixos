{ config, pkgs, inputs, ... }:

# Not reccomended to touch anything on this fiel unless you knwo what you are doing
# For settings you might wanan chnage go to common.nix

{
  imports =
    [ # Includes all modules in /modules/nix
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ../../modules/nixos/flatpak.nix # Flatpak packages
      ../../modules/nixos/packages.nix # System packages
      ../../modules/nixos/xorg.nix # X11 settings
      ../../modules/nixos/common.nix # Common settings
      ../../modules/nixos/display-manager.nix # Display manager i.e., login
      ../../modules/nixos/lenovo-stuff.nix # Lenovo stuff (Remove for most people)
    ];

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    catppuccin.enable = true;
    useOSProber = true;
    efiSupport = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Swap file
  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024; # 16GB swap file
  }];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Networking
  networking.hostName = "nixos";
  # networking.wireless.enable = true;  # If you wanan disable the wireless support, uncomment and set to flaske.
  # Enable networking
  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sq_AL.UTF-8";
    LC_IDENTIFICATION = "sq_AL.UTF-8";
    LC_MEASUREMENT = "sq_AL.UTF-8";
    LC_MONETARY = "sq_AL.UTF-8";
    LC_NAME = "sq_AL.UTF-8";
    LC_NUMERIC = "sq_AL.UTF-8";
    LC_PAPER = "sq_AL.UTF-8";
    LC_TELEPHONE = "sq_AL.UTF-8";
    LC_TIME = "sq_AL.UTF-8";
  };

  # XDG Portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.gnome-keyring ];

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kleidis = {
    isNormalUser = true;
    description = "kleidis";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Home Manager integration
  home-manager = {
    extraSpecialArgs = {inherit inputs; flake-inputs = inputs;};
    #backupFileExtension = "backup";
    users.kleidis = {
      imports = [
        inputs.catppuccin.homeManagerModules.catppuccin
        ./home.nix
      ];
    };
  };

  # polkit
    security.polkit.enable = true;
    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
      };
    };

  # dbus
  services.dbus.packages = [
      pkgs.gnome-keyring
      pkgs.pass-secret-service
      pkgs.gcr
    ];

  services.dbus.enable = true;
  services.upower.enable = true;
  services.dbus.implementation = "broker";
  services.gnome.gnome-keyring.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System state version
  system.stateVersion = "24.05";
}
