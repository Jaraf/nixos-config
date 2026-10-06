sudo nix --extra-experimental-features "nix-command flakes" run github:nix-community/disko -- --mode destroy,format ./hosts/jose-nb/disko-vm.nix
