{ pkgs, ... }:

{
  environment.systemPackages =
    let
      compilerTools = with pkgs; [
        clang
        nodejs_latest
      ];

      linters = with pkgs; [
        gitleaks
        nixpkgs-fmt
        pre-commit
        shellcheck
        shfmt
        stylua
      ];

      buildTools = with pkgs; [
        gnumake
        tree-sitter
      ];
    in
    compilerTools ++ linters ++ buildTools;
}
