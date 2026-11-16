{ inputs, self, ... }:
{
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
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
      self.nixosModules.home-manager
      {
        home-manager.users.x0lie.imports = [
          self.homeModules.cli
          self.homeModules.desktop
          self.homeModules.hyprland
          self.homeModules.plasma
          self.homeModules.brightness
          self.homeModules.brave
          self.homeModules.neovim
        ];
      }
    ];
  };
}
