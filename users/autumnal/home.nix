{ config, pkgs, ... }: {
  imports = [ ./gnome.nix ];

  xdg.configFile = {
    "alacritty".source = ./config/alacritty;

    "starship.toml".source = ./config/starship.toml;

    "easyeffects/output".source = ./config/easyeffects/output;

    "fcitx5/config".source = ./config/fcitx5/config;
    "fcitx5/conf/classicui.conf".source = ./config/fcitx5/conf/classicui.conf;
    "fcitx5/profile" = {
      source = ./config/fcitx5/profile;
      # Fcitx manages to write a new profile file before home manager comes in
      # So we overwrite the file by force
      force = true;
    };

    "cmus/autosave".source = ./config/cmus/autosave;
    "cmus/cmus-notify".source = ./config/cmus/cmus-notify;
    "cmus/merge_status_script.sh".source = ./config/cmus/merge_status_script.sh;
    "cmus/notify.cfg".source = ./config/cmus/notify.cfg;

    "dunst/dunstrc".source = ./config/dunst/dunstrc;

    "gtk-3.0/bookmarks".source = ./config/gtk-3.0/bookmarks;
  };

}
