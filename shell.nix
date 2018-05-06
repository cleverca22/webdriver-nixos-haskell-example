{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let
  config = {
    packageOverrides = pkgs: rec {
      selenium-server-standalone = pkgs.selenium-server-standalone.override {
                                   name = "selenium-server-standalone-2.53.1";
                                   version = "2.5.1";
                                   src = pkgs.fetchurl {
                                      url = "http://selenium-release.storage.googleapis.com/2.53/selenium-server-standalone-2.53.1.jar";
                                      sha256 = "1cce6d3a5ca5b2e32be18ca5107d4f21bddaa9a18700e3b117768f13040b7cf8";
                                      };
                                 };
    };
  };
  pkgs = import <nixpkgs> { inherit config; };

  f = { mkDerivation, base, chromedriver
      , selenium-server-standalone, stdenv, webdriver
      }:
      mkDerivation {
        pname = "webdriver-nixos-haskell-example";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = false;
        isExecutable = true;
        executableHaskellDepends = [ base webdriver ];
        executableSystemDepends = [
          chromedriver selenium-server-standalone
        ];
        license = stdenv.lib.licenses.bsd3;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f {});

in

  if pkgs.lib.inNixShell then drv.env else drv
