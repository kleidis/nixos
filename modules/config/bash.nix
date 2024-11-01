{ config, pkgs, ... }:

let

  tomlFormat = pkgs.formats.toml { };

in

{
  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "eza --icons";
      update = "cd ~/nixos && nix flake update";
      switch = ''
        #!/bin/bash
        echo "Select a host configuration:"
        select host in $(ls ~/nixos/hosts); do
          break
        done
        sleep 0
        switch="sudo nixos-rebuild switch --flake ~/nixos/#$host"
        echo $switch
        eval $switch
      '';
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
      pfetch
    '';
  };


  programs.starship = {
    enable = true;
  };

  home.file."${config.home.homeDirectory}/.config/starship.toml" = {
    source = ../../dotfiles/starship.toml;
  };
}