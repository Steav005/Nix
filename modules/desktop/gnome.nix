{ pkgs, inputs, info, ... }: {
  imports = [ ./common.nix ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = false;
    nvidiaWayland = false;
  };
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages =
    [ pkgs.gnome.gnome-tweaks pkgs.gnome.dconf-editor ];
}
