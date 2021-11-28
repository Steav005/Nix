{ config, ... }:
let configDir = "${config.home.homeDirectory}/Nix/users/autumnal/config/";
in {
  home.file.".face".source = ./profilepicture;

  programs.git = {
    enable = true;
    userName = "autumnal";
    userEmail = "friedrich122112@me.com";
    aliases = { st = "status"; };
  };

  xdg.configFile = {
    "alacritty".source = ./config/alacritty;

    "starship.toml".source = ./config/starship.toml;

    "easyeffects/output".source =
      config.lib.file.mkOutOfStoreSymlink "${configDir}/easyeffects/output";

    "fcitx5/config" = {
      source = ./config/fcitx5/config;
      force = true;
    };
    "fcitx5/conf/classicui.conf" = {
      source = ./config/fcitx5/conf/classicui.conf;
      force = true;
    };
    "fcitx5/profile" = {
      source = ./config/fcitx5/profile;
      force = true;
    };

    "cmus/autosave".source = ./config/cmus/autosave;
    "cmus/cmus-notify".source = ./config/cmus/cmus-notify;
    "cmus/merge_status_script.sh".source = ./config/cmus/merge_status_script.sh;
    "cmus/notify.cfg".source = ./config/cmus/notify.cfg;

    "dunst/dunstrc".source = ./config/dunst/dunstrc;

    "gtk-3.0/bookmarks".source =
      config.lib.file.mkOutOfStoreSymlink "${configDir}/gtk-3.0/bookmarks";
  };
}
