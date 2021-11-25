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
  };
}
