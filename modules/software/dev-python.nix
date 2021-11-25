{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
    let
      system-python-packages = python-packages:
        with python-packages; [
          docker_compose
          numpy
          requests
          dbus-python
          pygobject3
        ];
      system-python = python3.withPackages system-python-packages;
    in [ system-python ];
}
