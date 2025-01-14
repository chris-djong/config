{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.nodejs_22 pkgs.nodePackages.npm ];
}
