{ pkgs
, lib
, config
, user
, ...
}:
let
  shellAliases = {
    # Miscellaneous utilities
    os = "uname -o";
    # `ll` - list files with long format with `eza`
    ll = "${pkgs.eza}/bin/eza --long --header --icons";
    # `tree` - list files in a tree format with `eza`
    tree = "${pkgs.eza}/bin/eza --tree --long --header --icons";
  };
  enable = config.shell.bash || config.shell.zsh || config.shell.fish;
  initExtra = ''
    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    fi
  '';
in
{
  options.shell = {
    fish = lib.mkEnableOption "Enable Fish shell";
    zsh = lib.mkEnableOption "Enable Zsh shell";
    bash = lib.mkEnableOption "Enable Bash shell";
    enableAliases = lib.mkEnableOption "Enable shell aliases";
    enableFishShellPatch = lib.mkEnableOption "Add `initExtra` to shells to run Fish shell by default";
  };
  config = {
    home.shellAliases = shellAliases;
    home.sessionVariables = {
      GITHUB_HOME = "${config.xdg.userDirs.documents}/GitHub";
    };
    programs.bash = lib.mkIf config.shell.bash {
      enable = true;
      enableCompletion = true;
      initExtra = if config.shell.enableFishShellPatch && config.shell.bash then initExtra else "";
    };
    programs.zsh = lib.mkIf config.shell.zsh {
      enable = true;
      enableCompletion = true;
      history = {
        path = "${config.xdg.dataHome}/zsh/history";
        share = true;
      };
      initExtra = if config.shell.enableFishShellPatch && config.shell.zsh then initExtra else "";
    };
    programs.fish = lib.mkIf config.shell.fish {
      enable = true;
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
        {
          name = "${user.username}-config";
          src = ../../plugins/config;
        }
        {
          name = "${user.username}-tools";
          src = ../../plugins/tools;
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
    ];
  };
}
