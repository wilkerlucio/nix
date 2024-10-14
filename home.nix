{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  programs.home-manager.enable = true;

  home.username = "wilkerlucio";
  home.homeDirectory = lib.mkForce("/Users/wilkerlucio");

  home.stateVersion = "24.05";

  programs = {
    git = import ./home/git.nix {inherit pkgs;};
    zsh = import ./home/zsh.nix {inherit pkgs;};
  };
}
