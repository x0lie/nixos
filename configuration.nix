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

  boot.kernelPackages = pkgs.linuxPackages_7_1;
  boot.kernelModules = [
    "ntsync"
    "tcp_bbr"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

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
