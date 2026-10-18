{ config, pkgs, ... }:

{
  imports = [
    ./mc.nix
    ./onlyoffice.nix
  ];

  environment.systemPackages = with pkgs; [
    alsa-utils
    curl
    dnsutils
    fastfetch
    git
    home-manager
    htop
    kdePackages.kcalc
    kdePackages.sddm-kcm
    pciutils
    # pulseaudio
    usbutils
    vim
    wget
  ];
}
