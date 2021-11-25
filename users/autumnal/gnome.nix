{ ... }: {
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "Alacritty.desktop"
        "brave-browser.desktop"
        "spotify.desktop"
        "code.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      clock-show-weekday = true;

      gtk-theme = "Nordic";
      icon-theme = "Papirus-Dark";
      cursor-theme = "Bibata-Original-Classic";

      font-name = "Roboto 11";
      document-font-name = "Roboto 11";
      monospace-font-name = "FiraCode Nerd Font Mono 10";
    };
    #"org/gnome/settings-daemon/media-keys" = {
    #  custom-keybindings = [
    #    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/alacritty/"
    #    #"/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
    #  ];
    #  alacritty = {
    #    binding = "<Super>Enter";
    #    command = "alacritty";
    #    name = "Alacritty";
    #  };
    #};
  };
}
