{ ... }:
{
  flake.nixosModules.brightness =
    { pkgs, ... }:
    {
      users.users.x0lie.extraGroups = [ "video" ];
      services.udev.packages = [ pkgs.brightnessctl ];
    };

  flake.homeModules.brightness =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.brightnessctl ];
    };
}
