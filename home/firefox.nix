{ pkgs, config, ... }: {
  # - inspired by jakeginesin's config
  # - https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    policies = {
      # https://mozilla.github.io/policy-templates/#extensionsettings
      # TODO: do it like misterio77
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

        # LibRedirect
        "7esoorv3@alefvanoon.anonaddy.me" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/libredirect/latest.xpi";
          installation_mode = "normal_installed";
          default_area = "menupanel";
        };

        # Sidebery
        "{3c078156-979c-498b-8990-85f7987dd929}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sidebery/latest.xpi";
          installation_mode = "normal_installed";
          default_area = "menupanel";
        };

        # KeePassXC
        "keepassxc-browser@keepassxc.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
          installation_mode = "normal_installed";
          default_area = "navbar";
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
          nix-packages = nix-search "@np" "Nix Packages" "packages" [];
          nixos-options = nix-search "@no" "NixOS Options" "options" [];
          home-options = nix-search "@ho" "Home-Manager Options" "options" [
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
        "browser.cache.disk.enable" = false;
        # enables userContent.css and userChrome.css
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.urlbar.trimURLs" = false;
        "dom.disable_window_move_resize" = true;
        "widget.gtk.overlay-scrollbars.enabled" = false;
        "browser.tabs.inTitlebar" = 0; # csd
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.tabs.loadBookmarksInTabs" = true;
        "browser.startup.page" = 3;

        # make firefox a bit less annoying
        "browser.aboutConfig.showWarning" = false;
        "identity.fxaccounts.enabled" = false; # mozilla acc
        "browser.tabs.firefox-view" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.aboutwelcome.enabled" = false;
        "signon.rememberSignons" = false; # built-in password manager

        # force new tab
        "browser.link.open_newwindow" = 3;
        "browser.link.open_newwindow.restriction" = 0;

        # home page and new tab page
        "browser.startup.homepage" = "file://${config.xdg.userDirs.projects}/startpage/index.html";
        # TODO: custom new tab page
        "browser.newtabpage.enabled" = false; 

        # graphics: hardware acceleration
        "gfx.webrender.all" = true;
        "gfx.webrender.software" = false;

        "browser.contentblocking.category" = "strict";
        "media.eme.enabled" = false; # DRM
        "privacy.fingerprintingProtection" = true;
        "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme";
        "dom.security.https_only_mode" = true;

        # telemetry
        "app.shield.optoutstudies.enabled" = false;
        "browser.discovery.enabled" = false;
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
      };
    };
  };
}
