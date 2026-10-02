{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    vim
    htop
    fastfetch
    mc
  ];
}
