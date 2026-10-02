{ pkgs, ... }:
{
  hardware.graphics.enable = true;

  environment.systemPackages = [
    pkgs.intel-gpu-tools # gputop
  ];

  # intel
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vpl-gpu-rt
    libvdpau-va-gl
    intel-compute-runtime
  ];
  services.xserver.videoDrivers = [ "modesetting" ];
}
