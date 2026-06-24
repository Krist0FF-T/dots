{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ../common.nix
    ./graphics.nix
    ./self_hosting.nix # nextcloud, tailscale, samba
  ];

  networking.hostName = "gy8";
  home-manager.users.gyk = import ../../home;

  programs.steam.enable = true;

  system.stateVersion = "25.05";
}
