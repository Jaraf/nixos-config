{ config, pkgs, ... }:

{
  # Allow installation of unfree corefonts package
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "corefonts" ];
  
  fonts.fonts = with pkgs; [
    corefonts
  ];

  environment.systemPackages = [ pkgs.onlyoffice-desktopeditors ];
}
