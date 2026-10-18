{ config, pkgs, lib, ... }:

{
  environment.systemPackages = [ pkgs.onlyoffice-desktopeditors ];

# Allow installation of unfree corefonts package
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "corefonts" ];
  
#  fonts.fonts = with pkgs; [
#    corefonts
#  ];
  fonts.packages = with pkgs; [
    corefonts
  ];
}
