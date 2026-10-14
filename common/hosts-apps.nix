{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alsa-utils
    curl
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
