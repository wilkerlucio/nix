{ ... }: {
  programs.git = {
    enable = true;
    userName = "Wilker Lucio";
    userEmail = "wilkerlucio@gmail.com";

    extraConfig = {
      pull.rebase = false;
      rerere.enabled = true;
      init.defaultBranch = "main";
    };

    aliases = {
      s = "status";
      a = "!git add . && git status";
      au = "!git add -u . && git status";
      aa = "!git add . && git add -u . && git status";
      c = "commit";
      cm = "commit -m";
      ca = "commit --amend";
      ac = "!git add . && git commit";
      acm = "!git add . && git commit -m";
      l = "log --graph --all --pretty=format:'%C(yellow)%h%C(cyan)%d%Creset %s %C(white)- %an, %ar%Creset'";
      ll = "log --stat --abbrev-commit";
      lg = "log --color --graph --pretty=format:'%C(bold white)%h%Creset -%C(bold green)%d%Creset %s %C(bold green)(%cr)%Creset %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      llg = "log --color --graph --pretty=format:'%C(bold white)%H %d%Creset%n%s%n%+b%C(bold blue)%an <%ae>%Creset %C(bold green)%cr (%ci)' --abbrev-commit";
      d = "diff";
    };
  };
}
