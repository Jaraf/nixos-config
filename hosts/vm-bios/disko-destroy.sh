sudo nix --extra-experimental-features "nix-command flakes" run github:nix-community/disko -- --mode destroy,format,mount ./hosts/vm-bios/disko.nix
