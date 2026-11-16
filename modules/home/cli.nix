{ inputs, ... }:
{
  flake.homeModules.cli =
    {
      config,
      pkgs,
      configDir,
      ...
    }:

    {
      imports = [ inputs.nix-index-database.homeModules.default ];
      home.packages = with pkgs; [
        direnv
        dnsutils
        fastfetch
        gh
        git
        jq
        nixd
        nixfmt
        tcpdump
        tree
        wget
      ];

      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set -g fish_greeting
          fastfetch
        '';
        shellAliases = {
          ls = "ls -al --color";
          nrs = "sudo nixos-rebuild switch --flake ~/Projects/nixos";
          d = "docker";
          dcud = "docker compose up -d";
          dcd = "docker compose down";
        };
      };

      programs.starship = {
        enable = true;
        enableFishIntegration = true;
      };

      programs.nix-index = {
        enable = true;
        enableFishIntegration = true;
      };
      programs.nix-index-database.comma.enable = true;

      home.file."Projects/.editorconfig".source =
        config.lib.file.mkOutOfStoreSymlink "${configDir}/dotfiles/editorconfig";

      xdg.configFile."starship.toml".source =
        config.lib.file.mkOutOfStoreSymlink "${configDir}/dotfiles/starship/starship.toml";
    };
}
