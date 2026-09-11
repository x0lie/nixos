{ inputs, ... }:
{
  flake.nixosModules.plasma = {
    services.desktopManager.plasma6.enable = true;
  };

  flake.homeModules.plasma =
    { config, ... }:
    let
      cursor = config.home.pointerCursor;
    in
    {
      imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

      programs.plasma = {
        enable = true;

        workspace = {
          colorScheme = "BreezeDark";
          lookAndFeel = "org.kde.breezedark.desktop";
          theme = "breeze-dark";
          cursor = {
            theme = cursor.name;
            size = cursor.size;
          };
        };

        hotkeys.commands.kitty = {
          key = "Meta+Return";
          command = "kitty";
        };

        shortcuts.kwin = {
          "Window Close" = "Meta+Backspace";
          "Window Fullscreen" = "Meta+F";
        };
      };
    };
}
