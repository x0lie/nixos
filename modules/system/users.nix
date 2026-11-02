{ ... }:
{
  flake.nixosModules.users =
    { pkgs, ... }:
    {
      programs.fish.enable = true;

      users.users.x0lie = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        shell = pkgs.fish;
      };
    };
}
