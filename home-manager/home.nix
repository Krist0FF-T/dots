# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./games.nix
  ];

  # TODO: Set your username
  home = {
    username = "gyk";
    homeDirectory = "/home/gyk";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    element-desktop
    newsboat

    # creative
    godot
    blender
    kdePackages.kdenlive
    krita
    audacity
    gimp
    openutau

    # media
    zathura
    mpv
    vimiv-qt
    libreoffice-fresh
    mpc ncmpcpp rmpc # mpd stuff (new to it)
    ffmpeg
    yt-dlp
    ani-cli

    python313Packages.ipython
    uv
    cloc # count lines of code
    nushell
    tree
    file

    libqalculate # provides qalc
    khal # calendar

    fastfetch
    microfetch

    eza
    cava

    # fun stuff
    cowsay
    # sl figlet toilet lolcat

    # other
    pavucontrol
    gnome-clocks
    libnotify
    dunst
    wireguard-tools
    protonvpn-gui
    keepassxc

    # e
    sherlock
    nmap

    # breeze
    kdePackages.breeze
    kdePackages.breeze-gtk
    kdePackages.breeze-icons

    # # to check
    # burpsuite wireshark john hashcat ffuf
    # nnn
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    settings = {
      user.name = "Krist0FF-T";
      user.email = "155083075+Krist0FF-T@users.noreply.github.com";
      init.defaultBranch = "main";
    };
    lfs.enable = true;
  };

  services.mpd = {
    enable = true;
    musicDirectory = "/home/gyk/Music/";
    extraConfig = ''
        audio_output {
            type "pipewire"
            name "My PipeWire Output"
        }
    '';
  };

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      basedpyright # python LS
      clang-tools # clangd
      lua-language-server
      rust-analyzer-unwrapped
      stylua
      shfmt
      kdePackages.qtdeclarative # for QML LS
      astro-language-server
      nil # nix ls
    ];
  };
  xdg.configFile."nvim".source = ./lazyvim;

  qt = {
    enable = true;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };
  xdg.configFile."gtk-4.0/gtk.css".enable = lib.mkForce false;

  xdg.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
