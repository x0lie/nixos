{ inputs, self, ... }:
{
  flake.nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
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
      self.nixosModules.home-manager
      {
        home-manager.users.x0lie.imports = [
          self.homeModules.cli
          self.homeModules.desktop
          self.homeModules.hyprland
          self.homeModules.plasma
          self.homeModules.gaming
          self.homeModules.brave
          self.homeModules.neovim
        ];
      }
    ];
  };
}
