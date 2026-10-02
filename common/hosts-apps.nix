{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    fastfetch
    git
    htop
    mc
    vim
    wget
  ];
}
