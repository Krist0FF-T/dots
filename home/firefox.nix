{ pkgs, config, ... }: {
  # - inspired by jakeginesin's config
  # - https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    policies = {
      # https://mozilla.github.io/policy-templates/#extensionsettings
      ExtensionSettings = {
        "*".installation_mode = "blocked";

        # uBlock Origin - content blocker
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "normal_installed";
          default_area = "navbar";
          private_browsing = true;
        };

        # Privacy Badger
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "normal_installed";
          default_area = "menupanel";
        };

        # Dark Reader
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "normal_installed";
          default_area = "navbar";
        };

        # Unhook - block youtube home feed, side bar and more
        # Really like it but it's closed-source and has a non-free license
        "myallychou@gmail.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-recommended-videos/latest.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };
      };
    };
    profiles.default = {
      name = "Default";
      search = {
        force = true;
        default = "ddg";
        order = [ "ddg" "google" ];
        engines = let
          # search.nixos.org
          nix-search = alias: name: search_path: extraParams: {
            inherit name;
            urls = [{
              template = "https://search.nixos.org/${search_path}";
              params = [
                { name = "query"; value = "{searchTerms}"; }
                { name = "channel"; value = "unstable"; }
              ] ++ extraParams;
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ alias ];
          };
        in {
          nix-packages = nix-search "np" "Nix Packages" "packages" [];
          nixos-options = nix-search "no" "NixOS Options" "options" [];
          home-options = nix-search "ho" "Home-Manager Options" "options" [
            {name = "source"; value = "home_manager";}
          ];
        };
      };
      userChrome = ''
        /* Hide window control buttons */
        #titlebar-min, #titlebar-max, #titlebar-close {
          display: none !important;
        }

        .titlebar-buttonbox-container{
          display:none;
        }

        /* hide top right gap */
        .titlebar-spacer[type="post-tabs"] {
          display: none !important
        }
      '';
      # TODO: declarative bookmarks?
      # - I'd rather do it in my custom startpage and use fzf
      # bookmarks = {};
      settings = {
        "browser.tabs.unloadOnLowMemory" = true;
        # enables userContent.css and userChrome.css
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.aboutwelcome.enabled" = false;
        "browser.aboutConfig.showWarning" = false;

        "browser.startup.homepage" = "file:///home/gyk/dev/startpage/index.html";
        "browser.newtabpage.enabled" = false;
        # "browser.newtab.url" = ...; # unsupported, requires extension

        "gfx.webrender.all" = true;
        "gfx.webrender.software" = false;

        "browser.contentblocking.category" = "strict";
      };
    };
  };
}
