{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # dev
    cloc # count lines of code

    # global python for experimentation.
    (python3.withPackages (pp: [
      pp.pygame-ce
      pp.requests
      pp.matplotlib
      pp.pandas
    ]))

    ncdu # TUI disk usage
    tree
    file
    sshfs # mount over ssh
    trash-cli # use `trash` instead of `rm`

    yt-dlp
    ffmpeg
    libqalculate # provides qalc (calculator)
    khal # calendar
    python313Packages.qrcode # qr "some text"
    tealdeer # `tldr`, useful examples

    # fun stuff
    fastfetch
    microfetch
    cowsay
    cava
    # sl figlet toilet lolcat # some more

    nmap
    gocryptfs # encrypted directories
  ];

  programs.eza.enable = true;

  programs.tmux = {
    enable = true;
    # shell = "${pkgs.nushell}/bin/nu";
    keyMode = "vi"; # vim-like keybinds!
    escapeTime = 0;
    historyLimit = 9999;
    baseIndex = 1;
    extraConfig = ''
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R
      set -g status-bg black
      set -g status-fg gray

      bind -T root M-1  select-window -t 1
      bind -T root M-2  select-window -t 2
      bind -T root M-3  select-window -t 3
      bind -T root M-4  select-window -t 4
      bind -T root M-5  select-window -t 5
    '';
  };

  programs.nushell = {
    enable = true;
    settings.show_banner = false;
  };

  programs.bash.enable = true;

  programs.starship = {
    enable = true;
    settings = {
      battery.disabled = true;
    };
  };

  programs.yazi = {
    enable = true;
    enableBashIntegration = config.programs.bash.enable;
    enableNushellIntegration = config.programs.nushell.enable;
    # allows to "cd" visually! been wanting this for years
    shellWrapperName = "y";
  };

  programs.neovim = {
    enable = true;
    # package = pkgs.neovim-unwrapped;
    defaultEditor = true;
    withPython3 = true;
    withRuby = false;
    sideloadInitLua = true;
    extraPackages = with pkgs; [
      tree-sitter
      fd ripgrep
      basedpyright # python LS
      clang-tools # clangd
      lua-language-server
      rust-analyzer-unwrapped
      stylua
      shfmt
      kdePackages.qtdeclarative # for QML LS
      astro-language-server
      nil # nix ls
      nodejs-slim
      sqlite
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
}
