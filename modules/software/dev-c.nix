{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ clang clang-tools cmake gnumake ];
}
