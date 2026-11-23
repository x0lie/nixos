# Bootstrap:  nix run home-manager -- switch -b backup --flake ~/Projects/nixos#x0lie
# Then: hms
{ inputs, self, ... }:
{
  flake.homeConfigurations.x0lie = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    extraSpecialArgs.configDir = "/home/x0lie/Projects/nixos";
    modules = [
      self.homeModules.cli
      self.homeModules.neovim
      (
        { pkgs, configDir, ... }:
        {
          targets.genericLinux.enable = true;
          nix.package = pkgs.nix;
          nix.settings.experimental-features = [
            "nix-command"
            "flakes"
          ];

          programs.home-manager.enable = true;
          home.username = "x0lie";
          home.homeDirectory = "/home/x0lie";
          home.stateVersion = "26.05";

          programs.fish.shellAliases.hms = "home-manager switch --flake ~/Projects/nixos";

          # The user timer needs `loginctl enable-linger x0lie` to run without a session
          programs.nh = {
            enable = true;
            homeFlake = configDir;
            clean.enable = true;
            clean.dates = "weekly";
            clean.extraArgs = "--keep 3 --keep-since 5d";
          };
        }
      )
    ];
  };
}
