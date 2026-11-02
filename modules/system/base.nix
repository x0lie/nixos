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

      time.timeZone = "America/New_York";

      programs.nh = {
        enable = true;
        clean.enable = true;
        clean.dates = "weekly";
        clean.extraArgs = "--keep 8 --keep-since 5d";
      };
      programs.mtr.enable = true;
    };
}
