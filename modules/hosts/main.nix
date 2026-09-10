{ inputs, self, ... }:
let
  system = "x86_64-linux";
in
{
  flake.nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      ../../hardware-configurations/main.nix
      ../../configuration.nix
      { boot.loader.limine.extraEntries = ''
          /Windows
              protocol: efi
              path: guid(8f4ac44a-07fa-4b73-8e1f-649307fe4d1a):/EFI/Microsoft/Boot/bootmgfw.efi
        ''; }
      { networking.hostName = "main"; }
      self.nixosModules.nvidia
      self.nixosModules.hyprland
      self.nixosModules.gaming
      self.nixosModules.brave
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
            self.homeModules.brave
            inputs.nix-index-database.homeModules.default
          ];
        };
      }
    ];
  };
}
