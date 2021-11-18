{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ openssh ];
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

}
