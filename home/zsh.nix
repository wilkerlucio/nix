{ ... }: {
  programs.zsh = {
    enable = true;
    shellAliases = {
      g = "git status";
      gb = "git branch";
      gp = "git push";
      gl = "git pull";
      gpf = "git push --force-with-lease";
      gco = "git checkout";
      grmb = "git branch --merged | egrep -v \"(^\*|master|main|dev)\" | xargs git branch -d";
    };
    initExtra = ''
    '';
  };
}
