{
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";

  nixpkgs.config.allowUnfree = true;

  # Set once for bookkeeping, do not change this (reflects the original install)
  system.stateVersion = "26.05";

  #################
  # Boot / Kernel #
  #################

  boot.kernelPackages = pkgs.linuxPackages_7_2;
  boot.kernelModules = [
    "ntsync"
    "tcp_bbr"
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 2;

  boot.loader.limine = {
    enable = true;
    maxGenerations = 8;

    extraEntries = ''
      /Windows
          protocol: efi
          path: guid(8f4ac44a-07fa-4b73-8e1f-649307fe4d1a):/EFI/Microsoft/Boot/bootmgfw.efi
    '';

    style = {
      # Catppuccin Mocha
      wallpapers = [ ./assets/limine-wallpaper.png ];
      wallpaperStyle = "stretched";
      backdrop = "1E1E2E"; # base

      interface = {
        branding = "main";
        brandingColor = "CBA6F7"; # mauve
        helpColor = "A6E3A1"; # green
        helpColorBright = "94E2D5"; # teal
      };

      graphicalTerminal = {
        foreground = "CDD6F4"; # text
        brightForeground = "CDD6F4"; # text
        palette = "45475A;F38BA8;A6E3A1;F9E2AF;89B4FA;F5C2E7;94E2D5;BAC2DE";
        brightPalette = "585B70;F38BA8;A6E3A1;F9E2AF;89B4FA;F5C2E7;94E2D5;A6ADC8";
      };
    };
  };

  boot.kernel.sysctl."net.core.default_qdisc" = "fq";
  boot.kernel.sysctl."net.ipv4.tcp_congestion_control" = "bbr";

  boot.kernelParams = [ "preempt=full" ];

  services.scx = {
    enable = true;
    # scheduler = "scx_lavd";
    # extraArgs = [ "--performance" ];
    scheduler = "scx_bpfland";
    extraArgs = [
      "-m"
      "performance"
    ];
  };

  #################
  #   Hardware    #
  #################

  hardware.graphics.enable = true;
  virtualisation.docker.enable = true;

  #################
  #  Networking   #
  #################

  networking.hostName = "main";
  networking.firewall.checkReversePath = "loose";
  networking.networkmanager.enable = true;
  services.resolved.enable = true; # [local caching] necessary for full-speed Steam downloads

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  #################
  #    Config     #
  #################

  time.timeZone = "America/New_York";

  environment.sessionVariables = {
  };

  users.groups.nfsgroup = {
    gid = 1001;
  };

  users.users.x0lie = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "input"
      "docker"
      "nfsgroup"
    ];
    shell = pkgs.fish;
  };

  fileSystems."/mnt/nfs/media" = {
    device = "192.168.1.2:/mnt/OlsonNAS/nfs/media";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600"
      "_netdev"
    ];
  };

  #################
  #   Services    #
  #################

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  services.accounts-daemon.enable = true;
  services.power-profiles-daemon.enable = true;
  services.printing.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.mtr.enable = true;
}
