Setting this up.

## Install Nix

```
sh <(curl -L https://nixos.org/nix/install)
```

## Clone repo

```
nix-shell -p git --run "git clone git@github.com:wilkerlucio/nix.git"
```

## Apply configuration

```
darwin-rebuild switch --flake ~/nix#air
```
