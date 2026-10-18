{ config, pkgs, ... }:

{
  imports = [
    ./mc.nix
    ./onlyoffice.nix
  ];

  environment.systemPackages = with pkgs; [
    alsa-utils
    chromium
    curl
    dnsutils
    fastfetch
    firefox
    git
    home-manager
    htop
    kdePackages.kcalc
    kdePackages.sddm-kcm
    pciutils
    # pulseaudio
    usbutils
    vim
    vlc
    wget
  ];
}
