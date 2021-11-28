{ config, ... }: {
  home.file."GitRepos".source =
    config.lib.file.mkOutOfStoreSymlink "/media/ssddata/GitRepos";
}
