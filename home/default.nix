# Resources
# - `man home-configuration.nix`

# TODO:
# - cliphist

{
  config,
  pkgs,
  ...
}: let
  dot_config = "${config.home.homeDirectory}/dots/dot_config/";
  ln_conf = path: config.lib.file.mkOutOfStoreSymlink "${dot_config}/${path}";
in {
  imports = [
    ./games.nix
    ./git.nix
    ./firefox.nix
    ./terminal.nix
    ./theming.nix
  ];

  home.username = "gyk";
  home.homeDirectory = "/home/gyk";

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    setSessionVariables = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  xdg.configFile = {
    # TODO: for each, `x.source = ln x`
    "nvim".source = ln_conf "nvim";
    "quickshell".source = ln_conf "quickshell";
    "hypr".source = ln_conf "hypr";
    "foot".source = ln_conf "foot";
    "waybar".source = ln_conf "waybar";
    "matugen".source = ln_conf "matugen";
    "mpv/input.conf".source = ln_conf "mpv_input.conf";
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [
    qutebrowser
    # element-desktop # Matrix client (ew, electron based)
    dino # xmpp client (cute logo, native gtk, lightweight)
    newsboat # RSS reader
    kiwix # for offline wikipedia and more
    # freetube # yt frontend with local playlists, history, ..
    gnome-pomodoro
    activitywatch
    awatcher # wayland watcher for AW
    transmission_4-gtk
    digital # logisim-like electronics sim
    wordnet # offline word definitions
    wiremix # pipewire mixer

    # creative
    # godot # game engine
    # blender # modelling and animation
    # kdePackages.kdenlive # video editor

    ## graphics
    krita
    gimp
    inkscape

    # # sound / music
    # audacity
    # openutau # open singing synth, supports DiffSinger
    # vmpk # play piano (and more) with a simple qwerty keyboard
    # fluidsynth # real instrument samples
    # ardour # DAW (digital audio workstation)
    # lmms # another DAW, can't record external
    # zynaddsubfx # - foss synthesizer
    # qpwgraph # pipewire graph

    # media
    zathura # pdf reader
    vimiv-qt # vim-like image viewer
    libreoffice
    playerctl # required by multimedia key bindings
    mpc
    rmpc
    # pavucontrol
    wiremix
    imagemagick

    gnome-clocks
    # proton-vpn
    keepassxc

    # environment
    libnotify # for `notify-send` in scripts
    dunst # notification daemon, will replace with quickshell
    matugen # material you-based color scheme gen
    quickshell
    waybar
    wofi
    grim slurp
    hyprpicker
    hyprpaper
    hyprsunset
    adwaita-icon-theme
    brightnessctl
    wl-clipboard
    foot
  ];

  services.mpd = {
    enable = true;
    musicDirectory = config.xdg.userDirs.music;
    extraConfig = ''
        audio_output {
            type "pipewire"
            name "My PipeWire Output"
        }
    '';
  };

  programs.mpv = {
    enable = true;
    scripts = [ pkgs.mpvScripts.mpris ];
    # TODO:
    # - move to dot_config
    # - youtube profile: 1080p, subs (ytdl flag)
    config = {
      save-position-on-quit = true;
    };
  };

  services.hypridle.enable = true;

  # programs.direnv = {
  #   enable = true;
  #   # nix-direnv.enable = true;
  # };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
