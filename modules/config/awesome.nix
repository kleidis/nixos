{ config, pkgs, lib, ... }:

{
  home.file."${config.home.homeDirectory}/.config/awesome" = {
    source = ../../dotfiles/awesome;
    recursive = true;
  };
}