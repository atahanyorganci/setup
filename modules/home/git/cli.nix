{ lib
, config
, pkgs
, ...
}:
{
  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = config.user.name;
      userEmail = config.user.email;
      signing = {
        key = config.user.key;
        signByDefault = true;
      };
      ignores = [ ".DS_Store" ];
      delta = {
        enable = true;
        options = {
          navigate = true;
        };
      };
      extraConfig = {
        advice.addEmptyPathspec = false;
        branch.sort = "-committerdate";
        tag.sort = "version:refname";
        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          mnemonicPrefix = true;
          renames = true;
        };
        push = {
          followTags = true;
          autoSetupRemote = true;
        };
        fetch = {
          prune = true;
          pruneTags = true;
        };
        init.defaultBranch = "main";
        merge.conflictStyle = "zdiff3";
        core.editor = "code --wait";
        help.autocorrect = "prompt";
        rebase = {
          autoStash = true;
          autoSquash = true;
        };
        pull.rebase = true;
      };
    };
    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
}
