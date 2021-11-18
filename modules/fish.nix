{ config, pkgs, inputs, ... }:
let
  fzfConfig = ''
    set -x FZF_DEFAULT_OPTS "--preview='bat {} --color=always'" \n
    set -x SKIM_DEFAULT_COMMAND "rg --files || fd || find ."
  '';
in
{
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
      set nord0 2e3440
      set nord1 3b4252
      set nord2 434c5e
      set nord3 4c566a
      set nord4 d8dee9
      set nord5 e5e9f0
      set nord6 eceff4
      set nord7 8fbcbb
      set nord8 88c0d0
      set nord9 81a1c1
      set nord10 5e81ac
      set nord11 bf616a
      set nord12 d08770
      set nord13 ebcb8b
      set nord14 a3be8c
      set nord15 b48ead
      set fish_color_normal $nord4
      set fish_color_command $nord9
      set fish_color_quote $nord14
      set fish_color_redirection $nord9
      set fish_color_end $nord6
      set fish_color_error $nord11
      set fish_color_param $nord4
      set fish_color_comment $nord3
      set fish_color_match $nord8
      set fish_color_search_match $nord8
      set fish_color_operator $nord9
      set fish_color_escape $nord13
      set fish_color_cwd $nord8
      set fish_color_autosuggestion $nord3
      set fish_color_user $nord4
      set fish_color_host $nord9
      set fish_color_cancel $nord15
      set fish_pager_color_prefix $nord13
      set fish_pager_color_completion $nord3
      set fish_pager_color_description $nord10
      set fish_pager_color_progress $nord12
      set fish_pager_color_secondary $nord1

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
      rebuild = "sudo nixos-rebuild --flake ~/.config/nixos/";
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
