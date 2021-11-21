{ config, pkgs, inputs, info, ... }: {

  users.users.autumnal = {
    isNormalUser = true;
    extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "docker" ];
    shell = pkgs.fish;
    home = "/home/autumnal";
    description = "Sven Friedrich";
    hashedPassword =
      "$6$C2lvYMnUwU$fHgjzsQRizvJclKHgscbXiPjrFp0Zm5jvC7Qi1wBdn6poFZ.qDpqmqmuW2UcrT9G.sccZ1W6Htx4Qszf0id68/";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMNHbFYdDk7Ii7OsowH3Dn+dkEHAhJtqaxR6Q7V41OEX autumnal@last-order"
    ];
  };

  #environment.systemPackages = [
  # Needed for fcitx theme
  #inputs.my-flakes.packages."${info.arch}".fcitx5-nord
  #];

  home-manager.users.autumnal = {
    imports = [ ./autumnal/home.nix ];

    # TODO somehow move this into users/autumnal/home.nix
    home.file.".local/share/fcitx5/themes/".source =
      "${inputs.my-flakes.packages."${info.arch}".fcitx5-nord}";
  };
}
