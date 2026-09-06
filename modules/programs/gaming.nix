{ inputs, ... }:
{
  flake.nixosModules.gaming = {
    programs.steam.enable = true;
    programs.gamemode = {
      enable = true;
      settings = {
        cpu = {
          pin_cores = "yes";
          park_cores = "yes";
        };
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          dpu_device = 0;
          nv_powermizer_mode = 1;
        };
      };
    };
  };

  flake.homeModules.gaming =
    { config, pkgs, ... }:
    {
      home.packages = with pkgs; [
        gamescope
        mangohud
        protonplus
      ];

      xdg.configFile."MangoHud/MangoHud.conf".text = ''
        gpu_stats
        cpu_stats
        fps
        frametime
        # frame_timing_detailed
        dynamic_frame_timing
        fps_metrics=avg,0.01,0.001
        toggle_logging=Shift_L+F2
        output_folder=/home/x0lie/mangologs
      '';
    };
}
