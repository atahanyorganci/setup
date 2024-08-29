{
  pkgs,
  lib,
  config,
  ...
}:
let
  aliases = {
    # `git add`
    ga = "git add";
    gaa = "git add --all";
    gap = "git add --patch";
    # `git branch`
    gb = "git branch";
    gbl = "git branch --list";
    gbd = "git branch -D";
    # `git checkout`
    gc = "git commit";
    gca = "git commit --amend";
    gcm = "git commit -m";
    # `git rebase`
    gr = "git rebase";
    grc = "git rebase --continue";
    gra = "git rebase --abort";
    gri = "git rebase --interactive";
    # `git status`
    gs = "git status";
    # `git stash`
    gss = "git stash save";
    gsl = "git stash list";
    gsp = "git stash pop";
    # `git checkout`
    gco = "git checkout";
    gcb = "git checkout -b";
    # `git cherry-pick`
    gcp = "git cherry-pick";
    # `git log`
    gl = "git log --oneline --decorate --graph";
    # Logging utilities with Gum
    debug = "${pkgs.gum}/bin/gum log -t timeonly -l debug";
    info = "${pkgs.gum}/bin/gum log -t timeonly -l info";
    warn = "${pkgs.gum}/bin/gum log -t timeonly -l warn";
    error = "${pkgs.gum}/bin/gum log -t timeonly -l error";
    fatal = "${pkgs.gum}/bin/gum log -t timeonly -l fatal";
    # Hide banner for ffmpeg and ffprobe
    ffmpeg = "${pkgs.ffmpeg}/bin/ffmpeg -hide_banner";
    ffprobe = "${pkgs.ffmpeg}/bin/ffprobe -hide_banner";
    # Miscellaneous utilities
    os = "uname -o";
    # `wget`
    wget = "${pkgs.wget} --hsts-file=${config.xdg.cacheHome}/wget-hsts";
  };
  enable = config.shell.bash || config.shell.zsh || config.shell.fish;
  shellAliases = if enable && config.shell.enableAliases then aliases else { };
in
{
  options.shell = {
    fish = lib.mkEnableOption "Enable Fish shell";
    zsh = lib.mkEnableOption "Enable Zsh shell";
    bash = lib.mkEnableOption "Enable Bash shell";
    enableAliases = lib.mkEnableOption "Enable shell aliases";
  };
  config = {
    home.sessionVariables = {
      WGETRC = "${config.xdg.configHome}/wgetrc";
      GITHUB_HOME = "${config.xdg.userDirs.documents}/GitHub";
    };
    home.file = {
      "${config.xdg.configHome}/wgetrc".text = "";
    };
    xdg.enable = true;
    programs.bash = lib.mkIf config.shell.bash {
      enable = true;
      shellAliases = shellAliases;
      enableCompletion = true;
    };
    programs.zsh = lib.mkIf config.shell.zsh {
      enable = true;
      shellAliases = shellAliases;
      enableCompletion = true;
      history = {
        path = "${config.xdg.dataHome}/zsh/history";
        share = true;
      };
    };
    programs.fish = lib.mkIf config.shell.fish {
      enable = true;
      shellAliases = shellAliases;
      plugins = [
        {
          name = "autopair.fish";
          src = pkgs.fetchFromGitHub {
            owner = "jorgebucaran";
            repo = "autopair.fish";
            rev = "1.0.4";
            sha256 = "sha256-s1o188TlwpUQEN3X5MxUlD/2CFCpEkWu83U9O+wg3VU=";
          };
        }
        {
          name = "gitnow";
          src = pkgs.fetchFromGitHub {
            owner = "joseluisq";
            repo = "gitnow";
            rev = "2.12.0";
            sha256 = "sha256-PuorwmaZAeG6aNWX4sUTBIE+NMdn1iWeea3rJ2RhqRQ=";
          };
        }
        {
          name = "sponge";
          src = pkgs.fetchFromGitHub {
            owner = "meaningful-ooo";
            repo = "sponge";
            rev = "1.1.0";
            sha256 = "sha256-MdcZUDRtNJdiyo2l9o5ma7nAX84xEJbGFhAVhK+Zm1w=";
          };
        }
      ];
    };
    # starship - The minimal, blazing-fast, and infinitely customizable prompt for any shell!
    # GitHub Repository: https://github.com/starship/starship
    programs.starship = {
      enable = enable;
      enableBashIntegration = config.shell.bash;
      enableZshIntegration = config.shell.zsh;
      enableFishIntegration = config.shell.fish;
      settings = {
        aws.disabled = true;
        gcloud.disabled = true;
      };
    };
    # fzf - A command-line fuzzy finder
    # GitHub Repository: https://github.com/junegunn/fzf
    programs.fzf = {
      enable = enable;
      enableBashIntegration = config.shell.bash;
      enableZshIntegration = config.shell.zsh;
      enableFishIntegration = config.shell.fish;
      historyWidgetOptions = [ "--prompt='History> '" ];
    };
    # zoxide - A smarter cd command.
    # GitHub Repository: https://github.com/ajeetdsouza/zoxide
    programs.zoxide = {
      enable = enable;
      enableBashIntegration = config.shell.bash;
      enableZshIntegration = config.shell.zsh;
      enableFishIntegration = config.shell.fish;
    };
    home.packages = with pkgs; [
      eza
      bat
      delta
      fd
      sd
      ripgrep
      just
      dust
      gum
      hyperfine
      tokei
      onefetch
      neofetch
      go-task
      pandoc
      nixfmt-rfc-style
      ffmpeg
      qrencode
      wget
    ];
  };
}
