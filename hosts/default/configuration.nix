# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ./modules/nixos/flatpak.nix
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

  # NTFS
  boot.supportedFilesystems = [ "ntfs" ];


  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Tirane";

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

### SERVICES

  # GVFS
  services.gvfs.enable = true;
  # Thunar
  services.tumbler.enable = true;
  programs.xfconf.enable = true;

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
  # Declarative flatpak
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.xserver.desktopManager.cinnamon.enable = false;

  # AwesomeWM
  services.xserver.windowManager.awesome.enable = true;

  # Set lightdm as the display manager and awesome as the default session
  services.displayManager.sddm.package = pkgs.pkgs.kdePackages.sddm;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.catppuccin.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  services.xserver.displayManager.defaultSession = "none+awesome";
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xrdb}/bin/xrdb -merge <<EOF
    Xft.dpi: 125
    EOF
    waypaper --restore &
    systemctl --user --now start AutostartApps
  '';

  services.greenclip.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;


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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kleidis = {
    isNormalUser = true;
    description = "kleidis";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      vscode
      fastfetch
      copyq
      feh
      (pkgs.discord.override {
        withVencord = true;
      })
    ];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs; flake-inputs = inputs;};
#    backupFileExtension = "backup";
    users.kleidis = {
      imports = [
        inputs.catppuccin.homeManagerModules.catppuccin
        ./home.nix
      ];
    };
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "kleidis";

  # dbus

  services.dbus.enable = true;
  services.upower.enable = true;
  services.dbus.implementation = "broker";



  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Gnome keyring
  services.gnome.gnome-keyring.enable = true;

  # High DPI
  services.xserver.dpi = 125;

  environment.systemPackages = with pkgs; [
     git
     awesome
     gh
     pass-secret-service
     libsecret
     github-desktop
     polybarFull
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
     dbus
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

  fonts.packages = with pkgs; [
    font-awesome
    nerdfonts
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  # Copy .desktop files to the autostart directory
}