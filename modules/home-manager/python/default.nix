{ pkgs
, lib
, config
, ...
}:
let
  versions = {
    "3.9" = pkgs.python39;
    "3.10" = pkgs.python310;
    "3.11" = pkgs.python311;
    "3.12" = pkgs.python312;
  };
  availableVersions = builtins.attrNames versions;
  sortedVersions = builtins.sort (a: b: (builtins.compareVersions a b) < 0) availableVersions;
  latestVersion = builtins.elemAt sortedVersions (builtins.length sortedVersions - 1);
  python = versions.${config.python.version};
  pythonPackageTools = [
    (python.withPackages (
      pkgs: with pkgs; [
        black
        isort
        mypy
        pipx
        tox
        virtualenv
        pip
        ipython
        ipykernel
        matplotlib
        numpy
        pandas
      ]
    ))
  ];
  standaloneTools = with pkgs; [
    ruff
    poetry
    pipenv
  ];
  pythonTools = pythonPackageTools ++ standaloneTools;
in
{
  options.python = {
    enable = lib.mkEnableOption "Python";
    version = lib.mkOption {
      type = lib.types.enum sortedVersions;
      default = latestVersion;
      description = "The version of Python to install.";
    };
    installTools = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Install Python development tools.";
    };
  };
  config = lib.mkIf config.python.enable {
    home.sessionVariables = {
      PYTHONSTARTUP = "${config.xdg.configHome}/python/startup.py";
      PYTHONHISTFILE = "${config.xdg.cacheHome}/python/history.py";
    };
    home.packages = if config.python.installTools then pythonTools else [ python ];
    home.file = {
      ".config/ipython/profile_default/ipython_config.py" = {
        enable = config.python.installTools;
        source = ./ipython/profile_deafult/ipython_config.py;
      };
      ".config/python/startup.py" = {
        enable = true;
        source = ./python/startup.py;
      };
    };
  };
}
