{config, ...}:
{
  # graphics: nvidia / intel

  hardware.graphics.enable = true;

  # # intel
  # hardware.graphics.extraPackages = with pkgs; [
  #   intel-media-driver
  #   vpl-gpu-rt
  #   # intel-compute-runtime
  #   # intel-media-sdk
  # ];
  # environment.sessionVariables = {
  #   LIBVA_DRIVER_NAME = "iHD";
  # };
  # services.xserver.videoDrivers = [ "modesetting" ];

  # nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    # package = config.boot.kernelPackages.nvidiaPackages.beta;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    # >= Turing
    open = false;
  };
}
