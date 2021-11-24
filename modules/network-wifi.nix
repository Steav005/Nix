{ pkgs, ... }: {
  age.secrets.wifi-darwin = {
    file = ../secrets/wifi-darwin.age;
    path = "/etc/NetworkManager/system-connections/Vodafone-D43C.nmconnection";
  };
  age.secrets.wifi-clz-weeb = {
    file = ../secrets/wifi-clz-weeb.age;
    path = "/etc/NetworkManager/system-connections/WeebBox.nmconnection";
  };
  age.secrets.wifi-uslar-friedrich = {
    file = ../secrets/wifi-uslar-friedrich.age;
    path = "/etc/NetworkManager/system-connections/WLAN-Friedrich.nmconnection";
  };
  age.secrets.wifi-eduroam = {
    file = ../secrets/wifi-eduroam.age;
    path = "/etc/NetworkManager/system-connections/eduroam.nmconnection";
  };
}
