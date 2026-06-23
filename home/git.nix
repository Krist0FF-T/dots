
{ config, ... }: {
  programs.git = {
    enable = true;
    settings = {
      user.name = "Krist0FF-T";
      user.email = "155083075+Krist0FF-T@users.noreply.github.com";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
    lfs.enable = true;
    signing = {
      key = "${config.home.homeDirectory}/.ssh/id_ed25519";
      signByDefault = true;
      format = "ssh";
    };
  };

  programs.lazygit = {
    enable = true;
    settings.git.pagers = [
      {
        colorArg = "always";
        pager = "delta --paging=never";
      }
    ];
    settings.gui.theme = {
      selectedLineBgColor = [
        "black"
      ];
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      line-numbers = true;
      navigate = true;
      theme = "github";
    };
  };
}
