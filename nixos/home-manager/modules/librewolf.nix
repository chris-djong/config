{ config, pkgs, ... }:
let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in {
  programs = {
    librewolf = {
      enable = true;
      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
        "privacy.userContext.enabled" = false; # Disable container tabs
      };
      languagePacks = [ "en-US" ];

      # ---- POLICIES ----
      # Check about:policies#documentation for options.
      policies = {

        # Home settings
        Homepage = { URL = "about:blank"; };
        NewTabPage = { URL = "about:blank"; };
        NewWindowPage = { URL = "about:blank"; };

        # for guidelines how the urls were generated use <BS>https://mozilla.github.io/policy-templates/#extensionsettings>
        ExtensionSettings = {
          # To get an extension GUI use the following api https://addons.mozilla.org/api/v5/addons/search/?q=uBlock%20Origin
          # In the array of results, the first entry contains the guid.
          # You can also download the extension and then in about:debugging
          # uBlock Origin:
          "uBlock0@raymondhill.net" = {
            install_url =
              "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          # Bitwarden
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url =
              "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
          };
          # Vimium
          "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
            install_url =
              "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
            installation_mode = "force_installed";
          };
        };

        # ---- PREFERENCES ----
        # Check about:config for options.
        Preferences = { };
      };
    };
  };
}

