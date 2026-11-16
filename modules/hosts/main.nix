{ inputs, self, ... }:
let
  system = "x86_64-linux";
  configDir = "/home/x0lie/Projects/nixos";
in
{
  flake.nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      ../../hardware-configurations/main.nix
      {
        # Reflects original install; do not change:
        system.stateVersion = "26.05";
        networking.hostName = "main";
        boot.loader.limine.extraEntries = ''
          /Windows
              protocol: efi
              path: guid(8f4ac44a-07fa-4b73-8e1f-649307fe4d1a):/EFI/Microsoft/Boot/bootmgfw.efi
        '';
        # 2x4TB raid0 btrfs
        fileSystems."/mnt/hdd" = {
          device = "/dev/disk/by-label/hdd";
          fsType = "btrfs";
          options = [
            "compress=zstd"
            "noatime"
            "nofail"
          ];
        };
      }
      self.nixosModules.pc
      self.nixosModules.base
      self.nixosModules.users
      self.nixosModules.docker
      self.nixosModules.ssh-server
      self.nixosModules.ssh-client
      self.nixosModules.nfs-client
      self.nixosModules.hosts
      self.nixosModules.hyprland
      self.nixosModules.plasma
      self.nixosModules.gaming
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
            self.homeModules.gaming
            self.homeModules.brave
            self.homeModules.neovim
          ];
        };
      }
    ];
  };
}
