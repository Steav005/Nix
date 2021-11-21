{ pkgs, inputs, ... }: {
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = false;
    nvidiaWayland = true;
  };
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnome.dconf-editor
  ];
}
