{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alsa-utils
    curl
    dnsutils
    element-desktop
    fastfetch
    git
    home-manager
    htop
    kdePackages.kcalc
    kdePackages.sddm-kcm
    mc
    pciutils
    usbutils
    vim
    wget
  ];
}
