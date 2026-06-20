{ config, pkgs, ... }:
{
  # graphics: nvidia / intel

  hardware.graphics.enable = true;

  # TODO:
  # - hibrid graphics
  # - record using iGPU, since CPU encoding is slow and NVENC isn't supported

  # nixpkgs.config.permittedInsecurePackages = [
  #   "intel-media-sdk-23.2.2"
  # ];

  # intel
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    intel-compute-runtime
    libvdpau-va-gl
    # # quicksync can be supported through one of the following:
    # vpl-gpu-rt # -- unsupported on ice lake..
    # intel-media-sdk # -- deprecated, has vulnerabilities
  ];
  # environment.sessionVariables = {
  #   LIBVA_DRIVER_NAME = "iHD";
  # };
  # services.xserver.videoDrivers = [ "modesetting" ];

  # nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    nvidiaSettings = false;
    # >= Turing
    open = false;

    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";

      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };
}
