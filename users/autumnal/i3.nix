{ config, ... }: {
  xdg.configFile = {
    "i3" = {
      source = config.lib.file.mkOutOfStoreSymlink ./config/i3;
      force = true;
    };
    "polybar" = {
      source = ./config/polybar;
      force = true;
    };
    "gtk-3.0/settings.ini" = {
      source =
        config.lib.file.mkOutOfStoreSymlink ./config/gtk-3.0/settings.ini;
      force = true;
    };
  };
}
