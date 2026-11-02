{ ... }:
let
  adminKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBMpSVk2KurNXaKQG/qdV+I3wp+yGg9vOUgdsZboGGkD x0lie@main"
  ];

  hosts = {
    main.address = "192.168.1.100";
    nas.address = "192.168.1.2";
  };
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
    { lib, ... }:
    {
      programs.ssh.knownHosts = lib.mapAttrs (name: host: {
        hostNames = [
          name
          host.address
        ];
        publicKey = host.hostKey;
      }) (lib.filterAttrs (_: host: host ? hostKey) hosts);
      programs.ssh.startAgent = true;
    };

  flake.homeModules.ssh =
    { lib, ... }:
    {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings = lib.mapAttrs (_: host: { HostName = host.address; }) hosts // {
          "*".AddKeysToAgent = "yes";
        };
      };
    };
}
