{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  imports = [
    ./home/git.nix
    ./home/zsh.nix
  ];

  programs.home-manager.enable = true;

  home.username = "wilkerlucio";
  home.homeDirectory = lib.mkForce("/Users/wilkerlucio");

  home.stateVersion = "24.05";
}
