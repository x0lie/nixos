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
      {
        # Reflects original install; do not change:
        system.stateVersion = "26.05";
        networking.hostName = "laptop";
      }
      self.nixosModules.pc
      self.nixosModules.base
      self.nixosModules.users
      self.nixosModules.docker
      self.nixosModules.ssh-client
      self.nixosModules.nfs-client
      self.nixosModules.hosts
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
          home.stateVersion = "26.05";
          imports = [
            self.homeModules.cli
            self.homeModules.desktop
            self.homeModules.hyprland
            self.homeModules.plasma
            self.homeModules.brightness
            self.homeModules.brave
            self.homeModules.neovim
          ];
        };
      }
    ];
  };
}
