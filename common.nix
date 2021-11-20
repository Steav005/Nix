{ lib, pkgs, ... }:

{
  boot.cleanTmpDir = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  #boot.kernel.sysctl = {
  #  "vm.oom-kill" = 0;
  #  "vm.overcommit_memory" = 2;
  #  "vm.overcommit_ratio" = 200; # 200% overcommit
  #};
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  nix.trustedUsers = [ "admin" ];
  nixpkgs.config.allowUnfree = true;

  # enable zerotier virtual switch
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "565799d8f6299e0c" ];
  };

  # enable openssh
  environment.systemPackages = with pkgs; [ openssh ];
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  security.sudo.extraRules = [{
    users = [ "admin" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];

  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMNHbFYdDk7Ii7OsowH3Dn+dkEHAhJtqaxR6Q7V41OEX autumnal@last-order"
    ];
  };
}

