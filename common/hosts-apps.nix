{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alsa-utils
    curl
    dnsutils
    fastfetch
    git
    home-manager
    htop
    kdePackages.sddm-kcm
    mc
    pciutils
    usbutils
    vim
    wget
  ];
}
