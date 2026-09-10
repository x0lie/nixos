{ ... }:
{
  flake.nixosModules.brave = {
    environment.etc."brave/policies/managed/policies.json".text = builtins.toJSON {
      ShowHomeButton = true;
      PasswordManagerEnabled = false;
      ShowFullUrlsInAddressBar = true;

      DefaultSearchProviderEnabled = true;
      DefaultSearchProviderName = "Google";
      DefaultSearchProviderKeyword = "google";
      DefaultSearchProviderSearchURL = "https://www.google.com/search?q={searchTerms}";
      DefaultSearchProviderSuggestURL = "https://www.google.com/complete/search?client=chrome&q={searchTerms}";

      SiteSearchSettings = [
        {
          name = "YouTube";
          shortcut = "youtube";
          url = "https://www.youtube.com/results?search_query={searchTerms}";
        }
        {
          name = "GitHub";
          shortcut = "github";
          url = "https://github.com/search?q={searchTerms}&type=repositories";
        }
      ];
    };
  };

  flake.homeModules.brave =
    { ... }:
    {
      programs.brave-origin = {
        enable = true;
        extensions = [ "nngceckbapebfimnlniiiahkandclblb" ]; # Bitwarden
      };
    };
}
