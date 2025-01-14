{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.nodejs_20 pkgs.nodePackages.npm ];
}
