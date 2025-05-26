pkgs: {
  # Custom development shells
  # You can build them using 'nix develop .#example'
  gt-fhs = pkgs.callPackage ./gt-fhs.nix { };
}
