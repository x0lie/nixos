{ ... }:
{
  flake.nixosModules.nvidia =
    { config, ... }:
    {
      hardware.nvidia = {
        open = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia.nvidiaPersistenced = true;

      boot.kernelParams = [ "nvidia_drm.fbdev=1" ];
    };
}
