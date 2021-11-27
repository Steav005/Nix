{ lib, pkgs, overlay-unstable, inputs, info, ... }:

{
  environment.systemPackages = with pkgs; [
    unstable.alacritty

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
    unstable.papirus-icon-theme
    nordic
    bibata-cursors
    inputs.my-flakes.packages."${info.arch}".bibata

    # nitrogen
    gparted
    xorg.xev
    xorg.xinit
    # Replaced with: programs.dconf.enable = true;
    #gnome.dconf # Required by i.e. easyeffects
    brave
    firefox
    unstable.bitwarden
    numlockx # Turn on numlock
    qdirstat

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
    unstable.discord-canary
    element-desktop
    mattermost-desktop
    tdesktop
    unstable.rocketchat-desktop

    # Multimedia
    mpv
    syncplay
    spotify
    strawberry
    pavucontrol
    pamixer
    playerctl
    pulseaudio # For pactl
    unstable.easyeffects
    unstable.helvum
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
  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;

    config.pipewire = {
      "context.properties" = {
        "link.max-buffers" = 16;
        "log.level" = 2;
        "default.clock.rate" = 192000;
      };
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
    material-icons
    siji
    uw-ttyp0
    symbola
    fantasque-sans-mono
    material-design-icons
    source-han-code-jp
    source-code-pro
    jetbrains-mono
    iosevka

    # I3 Polybar relevant
    nerdfonts
    roboto
    sarasa-gothic
    font-awesome
  ];

  # Fallback Fonts
  fonts.fontconfig.defaultFonts = {
    monospace = [ "FiraCode Nerd Font" "Siji" "Symbola" "Sarasa Mono J" ];
    #   monospace = [ "DejaVu Sans Mono" "IPAGothic" ];
    #   sansSerif = [ "DejaVu Sans" "IPAPGothic" ];
    #   serif = [ "DejaVu Serif" "IPAPMincho" ];
  };

  # Console Font and Keymap
  console = {
    font = "FiraCode Nerd Font";
    keyMap = "de";
  };

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
    # Who needs caps anyway
    xkbOptions = "caps:ctrl_modifier";
  };

  # Enable gvfs
  services.gvfs.enable = true;
  environment.variables.GIO_EXTRA_MODULES = [ "${pkgs.gvfs}/lib/gio/modules" ];

  # Display configuration
  services.autorandr.enable = true;
}
