{ pkgs, ... }: {
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    registry."deploy-rs".to = {
      type = "github";
      owner = "serokell";
      repo = "deploy-rs";
    };
  };
}
