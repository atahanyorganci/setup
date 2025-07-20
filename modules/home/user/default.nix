# User configuration module
{ config, lib, ... }:
{
  options = {
    user = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "Full name of the user";
        example = "John Doe";
      };
      email = lib.mkOption {
        type = lib.types.str;
        description = "Email address of the user";
        example = "john.doe@example.com";
      };
      username = lib.mkOption {
        type = lib.types.str;
        description = "Username for the system";
        example = "johndoe";
      };
      shell = lib.mkOption {
        type = lib.types.str;
        default = "bash";
        description = "Default shell for the user";
        example = "fish";
      };
      key = lib.mkOption {
        type = lib.types.str;
        description = "GPG key ID";
        example = "ABCD1234EFGH5678";
      };
    };
  };
  config = {
    home.username = config.user.username;
  };
}
