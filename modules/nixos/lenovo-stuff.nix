{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    lenovo-legion
  ];

  boot.extraModulePackages = with config.boot.kernelPackages;
    [ lenovo-legion-module ];

  boot.kernelModules = [
    "lenovo-legion-module"
  ];
}
