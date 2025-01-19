{
  nix.gc = {
    automatic = false;
    dates = "daily";
    options = "--delete-older-than 7d";
  };
}
