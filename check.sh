nix --extra-experimental-features 'nix-command flakes' eval .#nixosConfigurations.jose-nb.config.system.build.toplevel
