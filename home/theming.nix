{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    kdePackages.breeze
    kdePackages.breeze-gtk
    kdePackages.breeze-icons

    qt6Packages.qt6ct
  ];

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    # TODO: declarative qtct config
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
}
