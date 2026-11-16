{ ... }:
{
  flake.nixosModules.base =
    { ... }:
    {
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      nix.settings.auto-optimise-store = true;

      nixpkgs.config.allowUnfree = true;

      time.timeZone = "America/New_York";

      boot.kernelModules = [ "tcp_bbr" ];
      boot.kernel.sysctl."net.core.default_qdisc" = "fq";
      boot.kernel.sysctl."net.ipv4.tcp_congestion_control" = "bbr";

      services.resolved.enable = true;

      programs.nh = {
        enable = true;
        clean.enable = true;
        clean.dates = "weekly";
        clean.extraArgs = "--keep 8 --keep-since 5d";
      };
      programs.mtr.enable = true;
    };
}
