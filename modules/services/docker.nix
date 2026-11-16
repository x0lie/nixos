{ ... }:
{
  flake.nixosModules.docker =
    { ... }:
    {
      virtualisation.docker.enable = true;
      users.users.x0lie.extraGroups = [ "docker" ];
    };
}
