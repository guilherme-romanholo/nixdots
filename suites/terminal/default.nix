{
  outputs,
  user,
  pkgs,
  ...
}: {
  imports = [
    outputs.homeManagerModules.terminal
  ];

  terminal = {
    fish.enable = true;

    git = {
      enable = true;
      username = user.username;
      email = user.email;
    };
  };

  home.packages = with pkgs; [
    neovim
  ];
}
