{ config, pkgs, ... }:

let

  tomlFormat = pkgs.formats.toml { };

in

{
  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "eza --icons";
      rebuild = "sudo nixos-rebuild switch  --flake ~/nixos/#default";
      update = "cd ~/nixos && nix flake update";
      clean = ''
        nix-collect-garbage --delete-old;
        sudo nix-collect-garbage --delete-older-than 30d;
        sudo nix-collect-garbage -d;
        sudo /run/current-system/bin/switch-to-configuration boot;
      '';

    };
    sessionVariables = {
      EDITOR="code";
      VISUAL="$EDITOR";
      PATH="$PATH:/home/kleidis/.local/bin";
    };
    initExtra = ''
      eval "$(zoxide init bash)"
    '';
  };


  programs.starship = {
    enable = true;
  };

  home.file."${config.home.homeDirectory}/.config/starship.toml" = {
    source = ../../dotfiles/starship.toml;
  };
}