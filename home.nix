{
  config,
  pkgs,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  programs.home-manager.enable = true;

  home.username = "wilkerlucio";
  home.homeDirectory = "/Users/wilkerlucio";

  home.stateVersion = "23.11";

  programs = {
    git = import ./home/git.nix {inherit pkgs;};
    zsh = import ./home/zsh.nix {inherit pkgs;};
  };
}
