{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    fastfetch
    git
    htop
    mc
    pciutils
    usbutils
    vim
    wget
  ];
}
