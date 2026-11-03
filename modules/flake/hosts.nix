{ config, lib, ... }:
let
  hosts = config.hosts;
in
{
  options.hosts = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
  };

  config.hosts = {
    nas = "192.168.1.2";
    main = "192.168.1.100";
  };

  # Resolves host names into addresses; creates ip = [ name ] for each host
  config.flake.nixosModules.hosts =
    {
      networking.hosts = lib.mapAttrs' (name: address: lib.nameValuePair address [ name ]) hosts;
    };
}
