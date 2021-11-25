{ config, ... }: {
  home.file.".face" = {
    source = ./profilepicture;
    force = true;
  };

  xdg.configFile = {
    "alacritty" = {
      source = ./config/alacritty;
      force = true;
    };

    "starship.toml" = {
      source = ./config/starship.toml;
      force = true;
    };

    "easyeffects/output" = {
      source = ./config/easyeffects/output;
      force = true;
    };

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

    "cmus/autosave" = {
      source = ./config/cmus/autosave;
      force = true;
    };
    "cmus/cmus-notify" = {
      source = ./config/cmus/cmus-notify;
      force = true;
    };
    "cmus/merge_status_script.sh" = {
      source = ./config/cmus/merge_status_script.sh;
      force = true;
    };
    "cmus/notify.cfg" = {
      source = ./config/cmus/notify.cfg;
      force = true;
    };

    "dunst/dunstrc" = {
      source = ./config/dunst/dunstrc;
      force = true;
    };

    "gtk-3.0/bookmarks" = {
      source = config.lib.file.mkOutOfStoreSymlink ./config/gtk-3.0/bookmarks;
      force = true;
    };
  };
}
