{ pkgs, ... }:
{
  programs.bash.enable = true;
  programs.zsh.enable = true;
  programs.fish = {
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
    ];
  };
  # starship - The minimal, blazing-fast, and infinitely customizable prompt for any shell!
  # GitHub Repository: https://github.com/starship/starship
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    settings = {
      aws.disabled = true;
      gcloud.disabled = true;
    };
  };
  # fzf - A command-line fuzzy finder
  # GitHub Repository: https://github.com/junegunn/fzf
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    historyWidgetOptions = [ "--prompt='History> '" ];
  };
  # zoxide - A smarter cd command.
  # GitHub Repository: https://github.com/ajeetdsouza/zoxide
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
  home.packages = with pkgs; [
    eza
    bat
    delta
    fd
    ripgrep
    just
    dust
    gum
    hyperfine
    go-task
  ];
}
