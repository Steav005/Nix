{ config, ... }: {
  home.file."GitRepos".source =
    config.lib.file.mkOutOfStoreSymlink "/media/ssddata/GitRepos";
  home.file."Music".source =
    config.lib.file.mkOutOfStoreSymlink "/media/ssddata/Music";
}
