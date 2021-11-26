{ config, pkgs, inputs, lib, nixpkgs, ... }: {

  imports = [ ./common.nix ];

  #  nixpkgs.overlays = [
  #    (final: previous: {
  #      picom = previous.picom.overrideAttrs (
  #        oldAttrs: rec {
  #          version = "next-ibhagwan";
  #          src = previous.fetchFromGitHub {
  #            "owner"= "ibhagwan";
  #            "repo"= "picom";
  #            "rev"= "60eb00ce1b52aee46d343481d0530d5013ab850b";
  #            "sha256"= "1m17znhl42sa6ry31yiy05j5ql6razajzd6s3k2wz4c63rc2fd1w";
  #            "fetchSubmodules"= true;
  #          };
  #        }
  #      );
  #    })
  #  ];

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
      "class_g ?= 'i3-frame'"
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
      defaultSession = "none+i3";
      lightdm.enable = true;
      lightdm.greeters.pantheon.enable = true;
      autoLogin = {
        enable = true;
        user = "autumnal";
      };
    };

    windowManager.i3 = {
      package = pkgs.i3-gaps;
      enable = true;
      extraPackages = with pkgs; [
        dmenu # application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock # default i3 screen locker
        i3blocks # if you are planning on using i3blocks over i3status
      ];
      #extraSessionCommands = ''
      #  ${pkgs.autorandr}/bin/autorandr --change --skip-options gamma,crtc,rotate,reflect,rate
      #'';
    };

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

      # Dunst alternative (Ill use dunst afterall)
      # inputs.wired-notify.packages.x86_64-linux.wired
      # notify-desktop
      dunst

      # i3 polybar
      polybar
      calc
      pywal
      rofi

      # Polybar dependency
      python39Packages.dbus-python
      python39Packages.pygobject3

      # Lockscreen
      unstable.betterlockscreen
      feh
    ];

  # Redshift
  services.redshift.enable = true;
}
