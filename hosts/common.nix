
{ pkgs, ... }: {

  users.users.gyk = {
    isNormalUser = true;
    description = "kristóf";
    extraGroups = [ "networkmanager" "wheel" ];
    # TODO: add authorized keys
  };

  programs.nix-ld.enable = true;
  programs.obs-studio.enable = true;

  programs.hyprland.enable = true;

  programs.thunar = {
    enable = true;
    plugins = [ pkgs.thunar-archive-plugin ];
  };
  services.tumbler.enable = true;
  services.gvfs.enable = true;

  programs.tmux = {
    enable = true;
    newSession = true; # when trying to attach
    keyMode = "vi"; # vim-like keybinds!
    escapeTime = 0;
  };

  environment.systemPackages = with pkgs; [
    vim
    htop btop
    git
    wget
    gcc
    zip unzip
    fzf
    ripgrep
    killall
    usbutils # lsusb

    # hypr
    foot
    waybar
    wofi
    grim slurp
    hyprpicker
    hyprpaper
    hyprlock
    networkmanagerapplet
    adwaita-icon-theme
    brightnessctl
    matugen
    libnotify # for notify-send
    dunst

    # nvim
    wl-clipboard

    hyprsunset # gammastep
    imagemagick
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

  security.polkit.enable = true;
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
  services.gnome.gnome-keyring.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  networking = {
    # Enable networking
    networkmanager.enable = true;
    wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    firewall.allowedTCPPorts = [ 4321 8080 443 80 ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };

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
      terminal.vt = 1;
      default_session = session;
      initial_session = session;
    };
  };

  services.power-profiles-daemon.enable = true; 
  powerManagement.cpuFreqGovernor = "performance";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.initrd.systemd.emergencyAccess = true;

  # boot.kernelParams = [ "quiet" ];
  # boot.plymouth.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };

  fileSystems."/mnt/E" = {
    # TODO: by-uuid instead
    device = "/dev/disk/by-label/ehdd";
    fsType = "ext4";
    options = [ "users" "nofail" "exec" ];
  };
}

