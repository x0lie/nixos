{ inputs, self, ... }:
let
  system = "x86_64-linux";
in
{
  flake.nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      ../../configuration.nix
      self.nixosModules.hyprland
      self.nixosModules.gaming
      inputs.home-manager.nixosModules.home-manager
      {
        environment.systemPackages = [ inputs.home-manager.packages.${system}.home-manager ];
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.users.x0lie = {
          imports = [
            ../../home.nix
            self.homeModules.hyprland
            self.homeModules.gaming
            inputs.nix-index-database.homeModules.default
          ];
        };
      }
    ];
  };
}
