{ config, pkgs, inputs, lib, nixpkgs, info, ... }: {

  imports = [ ./common.nix ];

  # Picom
  services.picom = {
    #    package = pkgs.nur.repos.reedrw.picom-next-ibhagwan;

    enable = true;
    backend = "xrender";
    vSync = false;
    refreshRate = 240;
    shadow = true;
    #shadowOffsets = [ (-12) (-6) ];
    shadowOffsets = [ (-5) (-5) ];
    shadowOpacity = 0.6;
    shadowExclude = [
      #"class_g ?= 'i3-frame'"
      "class_g ?= 'Polybar'"
      "_GTK_FRAME_EXTENTS@:c"
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
      "_NET_WM_STATE@[0]:32a = '_NET_WM_STATE_FULLSCREEN'"
      "_NET_WM_STATE@[1]:32a = '_NET_WM_STATE_FULLSCREEN'"
      "_NET_WM_STATE@[2]:32a = '_NET_WM_STATE_FULLSCREEN'"
      "_NET_WM_STATE@[3]:32a = '_NET_WM_STATE_FULLSCREEN'"
      "_NET_WM_STATE@[4]:32a = '_NET_WM_STATE_FULLSCREEN'"
      "_NET_WM_STATE@[5]:32a = '_NET_WM_STATE_FULLSCREEN'"
      "_NET_WM_STATE@[6]:32a = '_NET_WM_STATE_FULLSCREEN'"
      "_NET_WM_STATE@[7]:32a = '_NET_WM_STATE_FULLSCREEN'"
      "_NET_WM_STATE@[8]:32a = '_NET_WM_STATE_FULLSCREEN'"
      "_NET_WM_STATE@[9]:32a = '_NET_WM_STATE_FULLSCREEN'"
    ];
    wintypes = {
      "tooltip" = { "shadow" = false; };
      "fullscreen" = { "shadow" = false; };
      "dock" = { "shadow" = false; };
      "dnd" = { "shadow" = false; };
    };
    settings = {
      "unredir-if-possible" = true;
      "detect-transient" = true;
      "detect-client-leader" = true;
      "detect-rounded-corners" = true;
      "detect-client-opacity" = true;
      #      "use-damage" = false;

      # Shadow
      "shadow-radius" = 20;
      "shadow-ignore-shape" = true;

      #Blur
      #      "blur-method" = "dual_kawase";
      "blur-strength" = 6;
      "blur-background" = true;
      "blur-kern" = "7x7box";
      "blur-background-exclude" =
        [ "window_type = 'desktop'" "_GTK_FRAME_EXTENTS@:c" ];
    };
    opacityRules = [
      "0:_NET_WM_STATE@[0]:32a *= '_NET_WM_STATE_HIDDEN'"
      "0:_NET_WM_STATE@[1]:32a *= '_NET_WM_STATE_HIDDEN'"
      "0:_NET_WM_STATE@[2]:32a *= '_NET_WM_STATE_HIDDEN'"
      "0:_NET_WM_STATE@[3]:32a *= '_NET_WM_STATE_HIDDEN'"
      "0:_NET_WM_STATE@[4]:32a *= '_NET_WM_STATE_HIDDEN'"
      "0:_NET_WM_STATE@[5]:32a *= '_NET_WM_STATE_HIDDEN'"
      "0:_NET_WM_STATE@[6]:32a *= '_NET_WM_STATE_HIDDEN'"
      "0:_NET_WM_STATE@[7]:32a *= '_NET_WM_STATE_HIDDEN'"
      "0:_NET_WM_STATE@[8]:32a *= '_NET_WM_STATE_HIDDEN'"
      "0:_NET_WM_STATE@[9]:32a *= '_NET_WM_STATE_HIDDEN'"
    ];
  };

  services.xserver = {
    displayManager = {
      defaultSession = "none+leftwm";
      lightdm.enable = true;
      lightdm.greeters.gtk = {
        enable = true;
        theme = {
          name = "Nordic";
          package = pkgs.nordic;
        };
        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.unstable.papirus-icon-theme;
        };
        cursorTheme = {
          name = "Bibata-Original-Classic";
          package = inputs.my-flakes.packages."${info.arch}".bibata;
          size = 12;
        };
      };
      autoLogin = {
        enable = true;
        user = "autumnal";
      };
    };

    windowManager.leftwm.enable = true;

    screenSection = ''
      Option         "nvidiaXineramaInfoOrder" "DFP-5"
      Option         "metamodes" "DP-2: 1920x1080_240 +2560+0, DP-0: 2560x1440 +0+0"
    '';

    # Auto lock
    #xautolock = {
    #  enable = true;
    #  time = 45;
    #  locker =
    #    "${pkgs.betterlockscreen}/bin/betterlockscreen -l blur --display 1";
    #};

  };

  environment.systemPackages = with pkgs;
    let

      polybar = pkgs.polybar.override { i3Support = true; };
    in [
      # Pantheon theming
      pantheon.elementary-gtk-theme
      pantheon.elementary-icon-theme
      pantheon.elementary-sound-theme
      pantheon.elementary-wallpapers

      polkit_gnome

      # Dunst alternative (Ill use dunst afterall)
      # inputs.wired-notify.packages.x86_64-linux.wired
      # notify-desktop
      dunst

      # leftwm polybar
      polybar
      calc
      pywal
      rofi

      # Polybar dependency 
      # TODO move here from python dev
      #python39Packages.dbus-python
      #python39Packages.pygobject3

      # Lockscreen
      unstable.betterlockscreen
      feh
    ];

  security.polkit.enable = true;

  # Redshift
  services.redshift.enable = true;
}
