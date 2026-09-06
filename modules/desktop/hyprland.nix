{ inputs, ... }:
{
  flake.nixosModules.hyprland = {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    services.displayManager.dms-greeter = {
      enable = true;
      compositor.name = "hyprland";
    };
  };

  flake.homeModules.hyprland =
    { config, ... }:
    let
      configDir = "/home/x0lie/Projects/nixos";
    in
    {
      imports = [ inputs.dms.homeModules.dank-material-shell ];

      programs.dank-material-shell = {
        enable = true;
        systemd.enable = true;
        enableSystemMonitoring = true;
        enableDynamicTheming = true;
      };

      home.file.".config/hypr/hyprland.lua".source =
        config.lib.file.mkOutOfStoreSymlink "${configDir}/dotfiles/hypr/hyprland.lua";
    };
}
