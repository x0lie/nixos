{ ... }:
let
  nfsgroup = 1001;
in
{
  flake.nixosModules.nfs-client = {
    users.groups.nfsgroup.gid = nfsgroup;
    users.users.x0lie.extraGroups = [ "nfsgroup" ];

    fileSystems."/mnt/nfs/media" = {
      device = "nas:/mnt/OlsonNAS/nfs/media";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=600"
        "_netdev"
      ];
    };
  };
}
