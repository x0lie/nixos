{ config, pkgs, ... }:

let
  configDir = "/home/x0lie/Projects/nixos";
in

{
  home.username = "x0lie";
  home.homeDirectory = "/home/x0lie";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    brave
    claude-code
    direnv
    dnsutils
    efibootmgr
    fastfetch
    gamescope
    gh
    git
    grimblast
    hyprpicker
    jq
    kitty
    kubectl
    mangohud
    nemo
    neovim
    nixd
    nixfmt
    openbao
    protonplus
    spotify
    talosctl
    tree
    vesktop
    vlc
    wget
    wireguard-tools
    wofi
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

  programs.vscodium = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      arrterian.nix-env-selector
      editorconfig.editorconfig
      jnoortheen.nix-ide
      mkhl.direnv
    ];
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
      ls = "ls -al";
      nrs = "sudo nixos-rebuild switch --flake ~/Projects/nixos";
      d = "docker";
      k = "kubectl";
      t = "talosctl";
      dcud = "docker compose up -d";
      dcd = "docker compose down";
      windows = "sudo efibootmgr -n 0000 && sudo reboot";
      dbpt = "cd ~/Projects/pia-tun && docker buildx build --load -t x0lie/pia-tun:local . && cd ../testing && docker compose up -d --remove-orphans && docker logs pia-tun -f";
    };
  };

  programs.go.enable = true;

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.nix-index-database.comma.enable = true;

  home.file.".config/kitty".source = config.lib.file.mkOutOfStoreSymlink "${configDir}/configs/kitty";

  home.file."Projects/.editorconfig".source =
    config.lib.file.mkOutOfStoreSymlink "${configDir}/configs/editorconfig";

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
