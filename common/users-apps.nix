{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    vscode
    steam
    vlc
  ];
}
