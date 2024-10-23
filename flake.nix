{
  description = "Wilker Darwin system flake";

  inputs = {
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager, ... }:
  let
    configuration = { pkgs, ... }: {
      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        babashka
        bun
        clojure
        clojure-lsp
        corepack # npm, pnpm, yarn
        fx
        jdk21
        git
        jq
      ];

      homebrew = {
        enable = true;

        brews = [
          "deno"
          "mas"
          "youtube-dl"
        ];

        casks = [
          # commands
          "cljstyle"

          # apps
          "arc"
          "bartender"
          "beeper"
          "chatgpt"
          "discord"
          "iina"
          "intellij-idea"
          "iterm2"
          "istat-menus"
          "raycast"
          "roam-research"
          "slack"
          "spotify"
          "the-unarchiver"
          "visual-studio-code"
        ];

        masApps = {
          "Things 3" = 904280696;
          "Yoink" = 457622435;
        };

        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      system.defaults = {
        dock.persistent-apps = [
          "/Applications/ChatGPT.app"
          "/Applications/Roam Research.app"
          "/Applications/Arc.app"
          "/System/Applications/Calendar.app"
          "/Applications/Things3.app"
          "/System/Applications/Notes.app"
          "/Applications/IntelliJ IDEA.app"
          "/Applications/Visual Studio Code.app"
          "/Applications/Beeper.app"
          "/Applications/iTerm.app"
          "/System/Applications/System Settings.app"
        ];

        # disable hold for accent characters
        NSGlobalDomain.ApplePressAndHoldEnabled = false;

        NSGlobalDomain.AppleInterfaceStyle = "Dark";

        # key repeat initial delay
        NSGlobalDomain.InitialKeyRepeat = 1;
        # key repeat speed
        NSGlobalDomain.KeyRepeat = 1;
      };

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#air
    darwinConfigurations."air" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "wilkerlucio";
          };
        }
        home-manager.darwinModules.home-manager
        {
          # `home-manager` config
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.wilkerlucio = import ./home.nix;
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."air".pkgs;
  };
}
