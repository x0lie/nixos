{ ... }:
{
  flake.homeModules.neovim =
    { config, pkgs, ... }:
    let
      configDir = "/home/x0lie/Projects/nixos";
    in
    {
      home.sessionVariables.EDITOR = "nvim";

      home.packages = with pkgs; [
        fd
        gcc
        gnumake
        lazygit
        lua-language-server
        neovim
        ripgrep
        stylua
        wl-clipboard
      ];

      home.file.".config/nvim".source =
        config.lib.file.mkOutOfStoreSymlink "${configDir}/dotfiles/neovim";
    };
}
