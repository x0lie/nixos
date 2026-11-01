{ ... }:
{
  flake.homeModules.neovim =
    { config, pkgs, configDir, ... }:
    {
      home.sessionVariables.EDITOR = "nvim";

      home.packages = with pkgs; [
        fd
        gcc
        gnumake
        gofumpt
        gopls
        gotools
        lazygit
        lua-language-server
        neovim
        ripgrep
        stylua
        tree-sitter
        wl-clipboard
      ];

      home.file.".config/nvim".source =
        config.lib.file.mkOutOfStoreSymlink "${configDir}/dotfiles/neovim";
    };
}
