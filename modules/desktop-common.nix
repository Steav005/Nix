{ lib, pkgs, overlay-unstable, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    # Filemanager
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    (xfce.thunar.override {
      thunarPlugins = [ xfce.thunar-archive-plugin xfce.thunar-volman ];
    })
    gvfs

    ranger
    nnn

    xdg_utils
    handlr

    # Themes
    lxappearance
    dracula-theme
    papirus-icon-theme
    nordic
    bibata-cursors
    bibata-extra-cursors
    bibata-cursors-translucent

    # nitrogen
    gparted
    xorg.xev
    xorg.xinit
    # Replaced with: programs.dconf.enable = true;
    #gnome.dconf # Required by i.e. easyeffects
    brave
    firefox
    bitwarden
    numlockx # Turn on numlock

    # Font
    font-manager
    gucharmap

    # Office
    libreoffice
    languagetool
    texstudio
    zathura
    thunderbird
    qalculate-gtk

    # Communication
    discord
    element-desktop
    tdesktop

    # Multimedia
    mpv
    spotify
    strawberry
    pavucontrol
    pamixer
    playerctl
    pulseaudio # For pactl
    unstable.easyeffects
  ];

  # Required by i.e. easyeffects
  programs.dconf.enable = true;

  # Set default terminal env
  environment.sessionVariables.TERMINAL = [ "alacritty" ];

  hardware.xpadneo.enable = true;
  services.hardware.xow.enable = true;

  # Dbus replaced with rtkit
  #services.dbus = {
  #  enable = true;
  #  packages = [ pkgs.gnome3.dconf ];
  #};

  # Enable Pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    config.pipewire = {
      "context.properties" = {
        "link.max-buffers" = 16;
        "log.level" = 2;
        "default.clock.rate" = 192000;
        "default.clock.quantum" = 32;
        "default.clock.min-quantum" = 32;
        "default.clock.max-quantum" = 32;
        "core.daemon" = true;
        "core.name" = "pipewire-0";
      };
      "context.modules" = [
        {
          name = "libpipewire-module-rtkit";
          args = {
            "nice.level" = -15;
            "rt.prio" = 88;
            "rt.time.soft" = 200000;
            "rt.time.hard" = 200000;
          };
          flags = [ "ifexists" "nofail" ];
        }
        { name = "libpipewire-module-protocol-native"; }
        { name = "libpipewire-module-profiler"; }
        { name = "libpipewire-module-metadata"; }
        { name = "libpipewire-module-spa-device-factory"; }
        { name = "libpipewire-module-spa-node-factory"; }
        { name = "libpipewire-module-client-node"; }
        { name = "libpipewire-module-client-device"; }
        {
          name = "libpipewire-module-portal";
          flags = [ "ifexists" "nofail" ];
        }
        {
          name = "libpipewire-module-access";
          args = { };
        }
        { name = "libpipewire-module-adapter"; }
        { name = "libpipewire-module-link-factory"; }
        { name = "libpipewire-module-session-manager"; }
      ];
    };
  };

  # Fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts
    dina-font
    proggyfonts
    hanazono
    ipafont
    nerdfonts
    material-icons
    siji
    uw-ttyp0
    symbola
    fantasque-sans-mono
    material-design-icons
    source-han-code-jp
    source-code-pro
    roboto
    jetbrains-mono
    iosevka
    sarasa-gothic
  ];

  # Fallback Fonts
  fonts.fontconfig.defaultFonts = {
    monospace = [ "RobotoMono Nerd Font" "Siji" "Symbola" "Sarasa Gothic" ];
    #   monospace = [ "DejaVu Sans Mono" "IPAGothic" ];
    #   sansSerif = [ "DejaVu Sans" "IPAPGothic" ];
    #   serif = [ "DejaVu Serif" "IPAPMincho" ];
  };

  # Console Font
  console.font = "RobotoMono Nerd Font";

  # IME
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-mozc ];

  # XServer
  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = false;
    layout = "de";
    deviceSection = ''
      Option "TearFree" "on"
    '';
  };

  # Display configuration
  services.autorandr.enable = true;
}
