{ config, ... }:
let configDir = "${config.home.homeDirectory}/Nix/users/autumnal/config/";
in {
  xdg.configFile = {
    "i3".source = config.lib.file.mkOutOfStoreSymlink "${configDir}i3";
    "polybar".source =
      config.lib.file.mkOutOfStoreSymlink "${configDir}polybar";
    "gtk-3.0/settings.ini".source =
      config.lib.file.mkOutOfStoreSymlink "${configDir}gtk-3.0/settings.ini";
  };
}
