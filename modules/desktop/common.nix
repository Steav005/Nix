{ lib, pkgs, overlay-unstable, inputs, ... }:

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
    unstable.bitwarden
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
    discord-canary
    element-desktop
    mattermost
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
  };

  # Enable gvfs
  services.gvfs.enable = true;
  environment.variables.GIO_EXTRA_MODULES = [ "${pkgs.gvfs}/lib/gio/modules" ];

  # Display configuration
  services.autorandr.enable = true;
}
