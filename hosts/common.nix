
{ pkgs, ... }: {

  users.users.gyk = {
    isNormalUser = true;
    description = "kristóf";
    extraGroups = [ "networkmanager" "wheel" ];
    # TODO: add authorized keys
  };

  programs.nix-ld.enable = true;
  # programs.obs-studio.enable = true;
  programs.gpu-screen-recorder.enable = true;

  programs.hyprland.enable = true;

  programs.thunar = {
    enable = true;
    plugins = [ pkgs.thunar-archive-plugin ];
  };
  # services.tumbler.enable = true; # thumbnailer
  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    waypipe
    gpu-screen-recorder-gtk
    tmux
    neovim
    btop
    git
    wget
    gcc
    zip unzip
    fzf
    killall
    usbutils # lsusb
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-mono
    noto-fonts
    noto-fonts-cjk-sans
  ];

  # to be able to type in different writing systems
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc # (jp) 日本語
      fcitx5-rime # (zh) 中文
      fcitx5-m17n # (ru) Русский
      # GTK and Qt app support
      fcitx5-gtk
      kdePackages.fcitx5-qt
    ];
  };

  # Set your time zone.
  time.timeZone = "Europe/Budapest";

  # Select internationalisation properties.
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "hu_HU.UTF-8/UTF-8"
  ];
  i18n.defaultLocale = "en_US.UTF-8";

  # X11 and console keymap
  services.xserver.xkb.layout = "hu";
  console.keyMap = "hu";

  systemd.user.services.hyprpolkitagent = {
    description = "hyprpolkitagent";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  # Enable sound with pipewire.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.tailscale.enable = true;
  networking = {
    # Enable networking
    networkmanager.enable = true;
    wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    firewall.allowedTCPPorts = [ 4321 8080 443 80 ];
    # firewall.allowedUDPPorts = [ ... ];
  };

  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = false;
  programs.ssh.startAgent = true;

  services.openssh = {
    enable = true;
    # settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "no";
  };

  services.printing = {
    enable = true; # CUPS
    drivers = with pkgs; [
      # cnijfilter # Canon PIXMA MG2400 series
      gutenprint # fallback
    ];
  };

  hardware.bluetooth.enable = true;

  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
    HandleLidSwitch = "ignore";
  };

  services.greetd = let
    session = {
      user = "gyk";
      command = "${pkgs.tuigreet}/bin/tuigreet" +
          " --remember --time --asterisks" +
          " --greeting \"Szia Lajos!\"" +
          " --cmd start-hyprland";
    };
  in {
    enable = true;
    settings = {
      default_session = session;
      initial_session = session;
    };
  };

  services.power-profiles-daemon.enable = true; 
  powerManagement.cpuFreqGovernor = "performance";
  services.upower.enable = true; # reports %, for quickshell

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.initrd.systemd.emergencyAccess = true;

  # boot.kernelParams = [ "quiet" ];
  # boot.plymouth.enable = true;

  # compresses 50% of ram for use as swap
  zramSwap.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;
    auto-optimise-store = true;
  };
}

