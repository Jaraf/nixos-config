{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ mangohud ];

}
