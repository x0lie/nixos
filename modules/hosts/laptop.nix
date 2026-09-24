{ inputs, self, ... }:
let
  system = "x86_64-linux";
  configDir = "/home/x0lie/Projects/nixos";
in
{
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      ../../hardware-configurations/laptop.nix
      ../../configuration.nix
      { networking.hostName = "laptop"; }
      self.nixosModules.brightness
      self.nixosModules.hyprland
      self.nixosModules.plasma
      self.nixosModules.brave
      inputs.home-manager.nixosModules.home-manager
      {
        environment.systemPackages = [ inputs.home-manager.packages.${system}.home-manager ];
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.extraSpecialArgs = { inherit configDir; };
        home-manager.users.x0lie = {
          imports = [
            ../../home.nix
            self.homeModules.hyprland
            self.homeModules.plasma
            self.homeModules.brightness
            self.homeModules.brave
            self.homeModules.neovim
            inputs.nix-index-database.homeModules.default
          ];
        };
      }
    ];
  };
}
