{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alsa-utils
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
