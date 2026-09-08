{ inputs, ... }:
{
  flake.nixosModules.hyprland =
    { config, ... }:
    let
      cursor = config.home-manager.users.x0lie.home.pointerCursor;
    in
    {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
      };
      environment.systemPackages = [ cursor.package ];
      services.displayManager.dms-greeter = {
        enable = true;
        compositor.name = "hyprland";
        configHome = "/home/x0lie";

        compositor.customConfig = ''
          ${builtins.readFile ../../dotfiles/hypr/monitors.lua}
          ${builtins.readFile ../../dotfiles/hypr/devices.lua}
          ${builtins.readFile ../../dotfiles/hypr/config.lua}

          hl.env("DMS_RUN_GREETER", "1")

          hl.env("HYPRCURSOR_THEME", "${cursor.name}")
          hl.env("HYPRCURSOR_SIZE", "${toString cursor.size}")
          hl.env("XCURSOR_THEME", "${cursor.name}")
          hl.env("XCURSOR_SIZE", "${toString cursor.size}")
        '';
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

      home.file.".config/hypr".source =
        config.lib.file.mkOutOfStoreSymlink "${configDir}/dotfiles/hypr";
    };
}
