{ lib, ... }:
let
  nfsgroup = 1001;

  homeDirs = [
    "Documents"
    "Pictures"
    "Music"
  ];
  nfsMountOpts = [
    "x-systemd.automount"
    "x-systemd.idle-timeout=600"
    "x-systemd.mount-timeout=10"
    "nofail"
    "_netdev"
  ];
in
{
  flake.nixosModules.nfs-client = {
    users.groups.nfsgroup.gid = nfsgroup;
    users.users.x0lie.extraGroups = [ "nfsgroup" ];

    fileSystems = {
      "/mnt/nfs/media" = {
        device = "nas:/mnt/OlsonNAS/nfs/media";
        fsType = "nfs";
        options = nfsMountOpts;
      };
      "/mnt/nfs/x0lie" = {
        device = "nas:/mnt/OlsonNAS/home/x0lie";
        fsType = "nfs";
        options = nfsMountOpts;
      };
    }
    // lib.listToAttrs (
      map (
        d:
        lib.nameValuePair "/home/x0lie/${d}" {
          device = "nas:/mnt/OlsonNAS/home/x0lie/${d}";
          fsType = "nfs";
          options = nfsMountOpts;
        }
      ) homeDirs
    );
  };
}
