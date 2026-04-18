# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  lib,
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
    element-desktop # Matrix client
    newsboat # RSS reader

    # creative
    # godot
    # blender
    kdePackages.kdenlive
    krita
    audacity
    gimp
    openutau # open singing synth, supports DiffSinger

    # media
    zathura # pdf reader
    mpv
    vimiv-qt # vim-like image viewer
    libreoffice-fresh
    mpc ncmpcpp rmpc # mpd stuff (new to it)
    ffmpeg
    yt-dlp
    playerctl

    python313Packages.ipython
    uv # python
    cloc # count lines of code
    nushell

    tree
    file
    eza # ls alternative
    sshfs # mount over ssh

    libqalculate # provides qalc (calculator)
    khal # calendar
    python313Packages.qrcode # qr code gen
    zellij # tmux alternative

    fastfetch
    microfetch

    # fun stuff
    cowsay
    # sl figlet toilet lolcat

    quickshell
    pavucontrol
    gnome-clocks
    libnotify
    dunst # notification daemon, will replace with quickshell
    wireguard-tools
    protonvpn-gui
    keepassxc
    cava

    # e
    sherlock
    nmap
    gocryptfs # encrypted directories

    # breeze
    kdePackages.breeze
    kdePackages.breeze-gtk
    kdePackages.breeze-icons

    # # to check
    # burpsuite wireshark john hashcat ffuf
    # nnn
  ];

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
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;
    withPython3 = true;
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
  programs.home-manager.enable = true;
}
