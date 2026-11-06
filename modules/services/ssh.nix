{ ... }:
let
  adminKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBMpSVk2KurNXaKQG/qdV+I3wp+yGg9vOUgdsZboGGkD x0lie@main"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICFwekTgzvFmEUu01Luaz1YvHSyDPqyN+xC5VLYwNOAu x0lie@laptop"
  ];
in
{
  flake.nixosModules.ssh-server =
    { lib, ... }:
    {
      services.openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = lib.mkDefault false;
          KbdInteractiveAuthentication = lib.mkDefault false;
          PermitRootLogin = lib.mkDefault "no";
        };
      };

      users.users.x0lie.openssh.authorizedKeys.keys = adminKeys;
    };

  flake.nixosModules.ssh-client =
    {
      programs.ssh = {
        startAgent = true;
        extraConfig = ''
          AddKeysToAgent yes
        '';
      };
    };
}
