{ ... }:
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
      };
    };
  };

  flake.homeModules.gaming =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        gamescope
        mangohud
        prismlauncher
        protonplus
        xrandr
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
