# Resources
# - `man configuration.nix`

# TODO: write a rebuild script

{
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./graphics.nix
  ];

  users.users.gyk = {
    isNormalUser = true;
    description = "kristóf";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "password";
    # packages = with pkgs; [ ];

    # TODO: add authorized keys
  };

  home-manager.users.gyk = import ../home;

  programs.nix-ld.enable = true;

  programs.firefox.enable = true;
  programs.steam.enable = true;
  programs.obs-studio.enable = true;

  programs.hyprland = {
    enable = true;
    package = pkgs.unstable.hyprland;
  };

  programs.thunar = {
    enable = true;
    plugins = [ pkgs.thunar-archive-plugin ];
  };
  services.tumbler.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
    unstable.foot # unstable for colors-dark and colors-light
    waybar
    wofi
    grim slurp
    hyprpicker
    hyprpaper
    unstable.hyprlock
    networkmanagerapplet
    adwaita-icon-theme
    brightnessctl
    unstable.matugen
    libnotify # for notify-send
    dunst

    # nvim
    wl-clipboard

    hyprsunset # gammastep
    imagemagick
  ];

  programs.tmux = {
    enable = true;
    newSession = true; # when trying to attach
    keyMode = "vi"; # vim-like keybinds!
  };

  # environment.etc."nextcloud-admin-pass".text = "PWD";
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud33;
    hostName = "localhost";
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    config.dbtype = "sqlite";
    settings.trusted_domains = [
      "*.ts.net"  # for hosting on my tailnet
      "192.168.*" # for hosting locally
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-mono
    noto-fonts
    noto-fonts-cjk-sans
  ];

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = ''
        ${pkgs.tuigreet}/bin/tuigreet \
          --remember --time --asterisks \
          --greeting "Szia Lajos!" \
          --cmd start-hyprland
      '';
    };
  };

  services.power-profiles-daemon.enable = true; 
  powerManagement.cpuFreqGovernor = "performance";

  # ---------- low editing frequency ----------

  services.gvfs.enable = true;

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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  networking = {
    # Enable networking
    networkmanager.enable = true;
    hostName = "gyik-hp";
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    firewall.allowedTCPPorts = [ 4321 8080 443 80 ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
    package = pkgs.unstable.tailscale;
  };

  # See https://nixos.wiki/wiki/Samba
  services.samba = {
    enable = true;
    openFirewall = true;

    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        # ..
        "hosts allow" = "100. 192.168.0. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      "share" = {
        "path" = "/mnt/E/share/";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Budapest";

  # Select internationalisation properties.
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "hu_HU.UTF-8/UTF-8"
  ];
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # to be able to type in different writing systems
  # TODO: fix GTK IM warning
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

  # programs.ssh.startAgent = true;

  # List services that you want to enable:

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
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

  boot.kernelPackages = pkgs.linuxPackages_latest;
  # 6.12: SLTS (2035)
  # boot.kernelPackages = pkgs.linuxPackages_6_12;

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.kernelParams = [ "quiet" ];
  boot.plymouth.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
