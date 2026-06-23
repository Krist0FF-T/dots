{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./graphics.nix
    ../common.nix
  ];

  home-manager.users.gyk = import ../../home;

  networking.hostName = "gy7";

  system.stateVersion = "26.05";
}
