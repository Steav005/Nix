let
  last-order =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMNHbFYdDk7Ii7OsowH3Dn+dkEHAhJtqaxR6Q7V41OEX";
  neesama =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2untVWtTCezJeQxl40TJGsnDvDNXBiUxWnpN4oOdrp";
  systems = [ last-order neesama ];
in {
  "wifi-darwin.age".publicKeys = systems;
  "wifi-uslar-friedrich.age".publicKeys = systems;
  "wifi-clz-weeb.age".publicKeys = systems;
  "wifi-eduroam.age".publicKeys = systems;
}
