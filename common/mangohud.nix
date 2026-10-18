{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ mangohud ];


  # Forzar la inyección global de MangoHUD en aplicaciones y Steam
  environment.variables = {
    MANGOHUD = "1";
  };

  programs.steam = {
    extraCompatPackages = with pkgs; [
      mangohud
    ];
  };
}
