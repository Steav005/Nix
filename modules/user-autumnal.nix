{ config, pkgs, ... }:

{

  users.users.autumnal = {
    isNormalUser = true;
    extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "docker" ];
    shell = pkgs.fish;
    home = "/home/autumnal";
    description = "Sven Friedrich";
    hashedPassword =
      "$6$C2lvYMnUwU$fHgjzsQRizvJclKHgscbXiPjrFp0Zm5jvC7Qi1wBdn6poFZ.qDpqmqmuW2UcrT9G.sccZ1W6Htx4Qszf0id68/";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDCqT70dlmyBswNxuq8kS1PebEYuHf17lu3rv5QZhK5Ce3kk8op4yjURbXQ/6HeKxIZmTEZ4/F5oFSBcOBP5HE+FxmlwxjkbQvA9NyoynfnKMadikTvFrrWftiLatFJaoc0pfHbZ+L2lvno469OvviXxqQIY2al8Vw/08I38rG4lT/LEanUZ14ktwyOJY/1PCytIZ2R3fPnh5+y+EkTJR9aA5GcxythnfZTWeYT1AkXmyzEXD559Q4s+y5GJMSF7HI+BWZEXHnqB2uoEB5vEz3MSSajUkRrArbwEw927HKlyJGjpcPO25k1iaPIiVK3tRnrllmSpSAwumhXqc4byyNBs8fh6V2S/UBjrHlCWc9tD7ACRwZM7yShaQNrWpqklVVxGy/nJagAepgYwuiT7lskZV7GzZfK+zyyMD6UWMp4DUAe/ZpRT+DuWRQ1Ts1QZQUahCdon6rIBZ5gWJz5zHfv1gi7iSl8VQqrnDCEUj76932uqREiXw9hlRkFnHvOJP+Rq72Lo0bstPuptj71TTfHnW0K7UnuokSkXwTwg+dda+xVMtgSn8o6fXFt9AR5sY3NJRtI07hPMSJTQh7cmkDew+HUBYJ4S9XfI3rlhzPIeWEJ6iHJn5Od+oEU0sgtmY4ssbtRYDwxfubOtYPti4QlNxcRc29fw+wqgEujwsvwCw== Sven Friedrich"
    ];
  };
}
