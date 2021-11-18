{ config, pkgs, ... }:

{
  services.zerotierone = {
    enable = true;
    joinNetworks = [
      "565799d8f6299e0c" # Basic
      "12ac4a1e711ec1f6" # Weeb
    ];
  };
}
