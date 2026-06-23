# Resources
# - `man home-configuration.nix`

# TODO:
# - cliphist

{
  config,
  lib,
  pkgs,
  ...
}: let
  dot_config = "${config.home.homeDirectory}/dots/dot_config/";
  ln = path: config.lib.file.mkOutOfStoreSymlink "${dot_config}/${path}";
in {
  imports = [
    ./games.nix
    ./git.nix
  ];

  home.username = "gyk";
  home.homeDirectory = "/home/gyk";

  xdg.configFile = {
    # TODO: for each, `x.source = ln x`
    "nvim".source = ln "nvim";
    "quickshell".source = ln "quickshell";
    "hypr".source = ln "hypr";
    "foot".source = ln "foot";
    "waybar".source = ln "waybar";
    "matugen".source = ln "matugen";
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [
    qutebrowser
    element-desktop # Matrix client
    newsboat # RSS reader
    kiwix # for offline wikipedia and more

    # creative
    godot
    blender
    kdePackages.kdenlive
    krita
    audacity
    gimp
    openutau # open singing synth, supports DiffSinger
    inkscape

    # media
    zathura # pdf reader
    mpv
    vimiv-qt # vim-like image viewer
    libreoffice-fresh
    mpc ncmpcpp rmpc # mpd stuff (new to it)
    ffmpeg
    yt-dlp
    playerctl

    # dev
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
    tealdeer # tldr
    wikiman

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
    proton-vpn
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
    withRuby = false;
    sideloadInitLua = true;
    extraPackages = with pkgs; [
      tree-sitter
      fd
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

  programs.helix = {
    enable = true;

    # loosely based on fufexan's
    settings = {
      theme = "monokai";
      editor = {
        color-modes = true;
        # ..
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        # ..
        line-number = "relative";
        # ..
        soft-wrap.enable = true;
        statusline.center = [ "position-percentage" ];
        trim-final-newlines = true;
        trim-trailing-whitespace = true;
        whitespace.characters = {
          newline = "↴";
          tab = "⇥";
        };
      };
    };
  };

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

    gtk4.theme = config.gtk.theme;
  };
  xdg.configFile."gtk-4.0/gtk.css".enable = lib.mkForce false;

  xdg.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
