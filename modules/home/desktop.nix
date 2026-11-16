{ ... }:
{
  flake.homeModules.desktop =
    {
      config,
      pkgs,
      configDir,
      ...
    }:

    {
      home.packages = with pkgs; [
        adw-gtk3
        awscli2
        claude-code
        efibootmgr
        fluxcd
        go-task
        grimblast
        hyprpicker
        kitty
        kubecolor
        kubectl
        nemo
        nerd-fonts.jetbrains-mono
        openbao
        pinta
        plex-desktop
        qtengine
        sops
        spotify
        talhelper
        talosctl
        terraform
        vesktop
        vlc
        wireguard-tools
        wpsoffice
      ];

      programs.fish = {
        shellAliases = {
          k = "kubecolor";
          t = "talosctl";
          windows = "sudo efibootmgr -n 0000 && sudo reboot";
          dbpt = "cd ~/Projects/pia-tun && docker buildx build --load -t x0lie/pia-tun:local . && cd ../testing && docker compose up -d --remove-orphans && docker logs pia-tun -f";
        };
      };

      programs.vscodium = {
        enable = true;
        profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            arrterian.nix-env-selector
            editorconfig.editorconfig
            jnoortheen.nix-ide
            mkhl.direnv
          ];
          userSettings = {
            "nix.enableLanguageServer" = true;
            "nix.serverPath" = "nixd";
            "nix.serverSettings" = {
              "nixd" = {
                "nixpkgs" = {
                  "expr" = "import (builtins.getFlake \"${configDir}\").inputs.nixpkgs { }";
                };
                "options" = {
                  "nixos" = {
                    "expr" = "(builtins.getFlake \"${configDir}\").nixosConfigurations.main.options";
                  };
                  "home-manager" = {
                    "expr" =
                      "(builtins.getFlake \"${configDir}\").nixosConfigurations.main.options.home-manager.users.type.getSubOptions []";
                  };
                };
              };
            };
          };
        };
      };

      programs.go.enable = true;

      home.pointerCursor = {
        enable = true;
        package = pkgs.catppuccin-cursors.latteDark;
        name = "catppuccin-latte-dark-cursors";
        size = 24;
        gtk.enable = true;
        x11.enable = true;
        hyprcursor.enable = true;
      };

      home.file."Pictures/Wallpapers".source =
        config.lib.file.mkOutOfStoreSymlink "${configDir}/dotfiles/wallpapers";

      home.file.".config/kitty".source =
        config.lib.file.mkOutOfStoreSymlink "${configDir}/dotfiles/kitty";

      xdg.configFile."wireplumber/wireplumber.conf.d/51-prefer-minifuse-mic.conf".text = ''
        monitor.alsa.rules = [
          {
            matches = [
              { node.name = "~alsa_input.usb-ARTURIA_MiniFuse.*Mic.*" }
            ]
            actions = {
              update-props = {
                priority.session = 3000
              }
            }
          }
        ]
      '';
    };
}
