(pkgs, ...): {
  font.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
    iosevka
  ];
}
