{ pkgs ? import <nixpkgs> {} }:

(pkgs.buildFHSEnv {
  name = "GlamorousToolkit";
  targetPkgs = pkgs: (with pkgs; [
    bash
    coreutils
    gcc
    iputils
    libcap
    curl
    libxcrypt-legacy
    fontconfig
    freetype
    libz
    linux-pam
    rpcbind
    which
    zip
    cairo
    dbus
    glib
    gtk3
    libgit2
    libglvnd
    libuuid
    harfbuzz
    libsoup_3
    webkitgtk_4_1
    zenity
    libxkbcommon
  ]) ++ (with pkgs.xorg; [
    libX11
    libXft
    libxcb
    libXcursor
    libXext
    libXi
    libXrandr
    libXrender
  ]);
  runScript = "zsh";
}).env
