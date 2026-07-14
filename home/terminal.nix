{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # dev
    python313Packages.ipython
    uv # python
    cloc # count lines of code
    nushell # for scripting

    ncdu # TUI disk usage
    tree
    file
    eza # ls alternative
    sshfs # mount over ssh
    trash-cli # use `trash` instead of `rm`

    yt-dlp
    ffmpeg
    libqalculate # provides qalc (calculator)
    khal # calendar
    python313Packages.qrcode # qr "some text"
    zellij # tmux alternative, don't really use it
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
}
