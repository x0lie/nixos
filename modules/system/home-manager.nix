{ inputs, ... }:
{
  # Shared home-manager wiring; hosts only list the required homeModules
  flake.nixosModules.home-manager =
    { config, pkgs, ... }:
    {
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      environment.systemPackages = [
        inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.home-manager
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs.configDir = "/home/x0lie/Projects/nixos";
        users.x0lie.home.stateVersion = config.system.stateVersion;
      };
    };
}
