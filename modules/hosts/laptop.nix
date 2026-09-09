{ inputs, self, ... }:
let
  system = "x86_64-linux";
in
{
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      ../../hardware-configurations/laptop.nix
      ../../configuration.nix
      { networking.hostName = "laptop"; }
      self.nixosModules.hyprland
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
            inputs.nix-index-database.homeModules.default
          ];
        };
      }
    ];
  };
}
