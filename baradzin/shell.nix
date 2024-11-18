{
  pkgs ? import <nixpkgs> { overlays = [ (import <bsuir-tex/nixpkgs>) ]; },
}:
with pkgs;
mkShell.override { inherit (swiftPackages) stdenv; } rec {
  name = "MPL-1";

  vscode-settings = writeText "settings.json" (
    builtins.toJSON {
      "swift.path" = "${swiftPackages.swift-unwrapped}/bin";
      "swift.sourcekit-lsp.serverPath" = "${swiftPackages.sourcekit-lsp}/bin/sourcekit-lsp";
      "lldb.library" = "${swiftPackages.swift-unwrapped}/lib/liblldb.so";
      "lldb.launch.expressions" = "native";
    }
  );

  packages = [
    (texliveMedium.withPackages (_: with texlivePackages; [ bsuir-tex ]))
    inkscape-with-extensions
    python312Packages.pygments
    gradle
    kotlin
    swift
    swiftpm
    swift-format
    swiftPackages.Foundation
    swiftPackages.Dispatch
  ];

  shellHook = ''
    LD_LIBRARY_PATH+=":${swiftPackages.Dispatch}/lib";
    mkdir .vscode &>/dev/null
    cp --force ${vscode-settings} .vscode/settings.json
  '';
}
