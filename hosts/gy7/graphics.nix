{ pkgs, ... }:
{
  hardware.graphics.enable = true;

  # intel
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vpl-gpu-rt
    libvdpau-va-gl
    intel-compute-runtime
  ];
  services.xserver.videoDrivers = [ "modesetting" ];
}
