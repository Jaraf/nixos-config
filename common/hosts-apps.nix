{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    fastfetch
    git
    htop
    kdePackages.sddm-kcm
    mc
    pciutils
    usbutils
    vim
    wget
  ];
}
