{ config, pkgs, inputs, info, lib, ... }:
let
  xserver = config.services.xserver;
  conditionalImports =
    lib.optional xserver.displayManager.gdm.enable ./autumnal/gnome.nix
    ++ lib.optional xserver.windowManager.i3.enable ./autumnal/i3.nix
    ++ lib.optional xserver.windowManager.leftwm.enable ./autumnal/leftwm.nix
    ++ lib.optional (info.hostname == "neesama") ./autumnal/neesama.nix;
in {
  users.users.autumnal = {
    uid = 1000;
    isNormalUser = true;
    extraGroups =
      [ "wheel" "disk" "input" "audio" "video" "networkmanager" "docker" ];
    shell = pkgs.fish;
    home = "/home/autumnal";
    description = "Sven Friedrich";
    hashedPassword =
      "$6$C2lvYMnUwU$fHgjzsQRizvJclKHgscbXiPjrFp0Zm5jvC7Qi1wBdn6poFZ.qDpqmqmuW2UcrT9G.sccZ1W6Htx4Qszf0id68/";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMNHbFYdDk7Ii7OsowH3Dn+dkEHAhJtqaxR6Q7V41OEX autumnal@last-order"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2untVWtTCezJeQxl40TJGsnDvDNXBiUxWnpN4oOdrp autumnal@neesama"
    ];
  };

  # Age ssh encryption location
  age.identityPaths = [ "/home/autumnal/.ssh/id_ed25519" ];

  home-manager.users.autumnal = {
    imports = [ ./autumnal/home.nix ] ++ conditionalImports;

    # TODO somehow move this into users/autumnal/home.nix
    home.file.".local/share/fcitx5/themes/".source =
      "${inputs.my-flakes.packages."${info.arch}".fcitx5-nord}";

    # TODO move into i3 (maybe?)
    xsession.pointerCursor = {
      package = inputs.my-flakes.packages."${info.arch}".bibata;
      name = "Bibata-Original-Classic";
      size = 12;
    };
  };
}
