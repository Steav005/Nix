{ config, pkgs, inputs, ... }:
let
  fzfConfig = ''
    set -x FZF_DEFAULT_OPTS "--preview='bat {} --color=always'" \n
    set -x SKIM_DEFAULT_COMMAND "rg --files || fd || find ."
  '';
in {
  environment.systemPackages = with pkgs; [
    starship # Prompt
    any-nix-shell # fish for nixshell
  ];

  # Enable Fish
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      #
      # COLOR THEME
      #

      set -g fish_color_autosuggestion '555'  'brblack'
      set -g fish_color_cancel -r
      set -g fish_color_command --bold
      set -g fish_color_comment red
      set -g fish_color_cwd green
      set -g fish_color_cwd_root red
      set -g fish_color_end brmagenta
      set -g fish_color_error brred
      set -g fish_color_escape 'bryellow'  '--bold'
      set -g fish_color_history_current --bold
      set -g fish_color_host normal
      set -g fish_color_match --background=brblue
      set -g fish_color_normal normal
      set -g fish_color_operator bryellow
      set -g fish_color_param cyan
      set -g fish_color_quote yellow
      set -g fish_color_redirection brblue
      set -g fish_color_search_match 'bryellow'  '--background=brblack'
      set -g fish_color_selection 'white'  '--bold'  '--background=brblack'
      set -g fish_color_user brgreen
      set -g fish_color_valid_path --underline

      # Hooks
      starship init fish | source
      any-nix-shell fish | source
    '';

    shellInit = with pkgs; ''
      source ${skim}/share/skim/key-bindings.fish
      function fish_user_key_bindings
        skim_key_bindings
      end

      set -x FZF_DEFAULT_OPTS "--preview='bat {} --color=always'" \n
      set -x SKIM_DEFAULT_COMMAND "rg --files || fd || find ."
    '';

    shellAliases = {
      ls = "exa";
      find = "fd";
      vim = "nvim";
      cat = "bat --paging=never -p";
      rebuild = "sudo nixos-rebuild switch --flake ~/Documents/Nix/";
      update-background =
        "betterlockscreen -u ~/Pictures/Wallpaper/venti.png --display 1 -u ~/Pictures/Wallpaper/ganyu.png";
    };

    vendor = {
      config.enable = true;
      functions.enable = true;
      completions.enable = true;
    };
  };
}
