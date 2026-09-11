{ config, pkgs, ... }:

let
  configDir = "/home/x0lie/Projects/nixos";
in

{
  home.username = "x0lie";
  home.homeDirectory = "/home/x0lie";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    adw-gtk3
    claude-code
    direnv
    dnsutils
    efibootmgr
    fastfetch
    gh
    git
    grimblast
    hyprpicker
    jq
    kitty
    kubecolor
    kubectl
    nemo
    neovim
    nerd-fonts.jetbrains-mono
    nixd
    nixfmt
    openbao
    qtengine
    spotify
    talosctl
    tcpdump
    tree
    vesktop
    vlc
    wget
    wireguard-tools
  ];

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
                "expr" = "(builtins.getFlake \"${configDir}\").nixosConfigurations.main.options.home-manager.users.type.getSubOptions []";
              };
            };
          };
        };
      };
    };
  };

  home.pointerCursor = {
    enable = true;
    package = pkgs.catppuccin-cursors.latteDark;
    name = "catppuccin-latte-dark-cursors";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
      fastfetch
    '';
    shellAliases = {
      ls = "ls -al --color";
      nrs = "sudo nixos-rebuild switch --flake ~/Projects/nixos";
      d = "docker";
      k = "kubecolor";
      t = "talosctl";
      dcud = "docker compose up -d";
      dcd = "docker compose down";
      windows = "sudo efibootmgr -n 0000 && sudo reboot";
      dbpt = "cd ~/Projects/pia-tun && docker buildx build --load -t x0lie/pia-tun:local . && cd ../testing && docker compose up -d --remove-orphans && docker logs pia-tun -f";
    };
  };

  programs.go.enable = true;

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.nix-index-database.comma.enable = true;

  home.file."Pictures/Wallpapers".source =
    config.lib.file.mkOutOfStoreSymlink "${configDir}/dotfiles/wallpapers";

  home.file.".config/kitty".source =
    config.lib.file.mkOutOfStoreSymlink "${configDir}/dotfiles/kitty";

  home.file."Projects/.editorconfig".source =
    config.lib.file.mkOutOfStoreSymlink "${configDir}/dotfiles/editorconfig";

  xdg.configFile."starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${configDir}/dotfiles/starship/starship.toml";

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
}
