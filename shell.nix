{ nixpkgs ? import <nixpkgs> {}, compiler ? "default", doBenchmark ? false }:

let
  config = {
    packageOverrides = pkgs: rec {
      selenium-server-standalone = pkgs.selenium-server-standalone.overrideAttrs (oldAttrs: rec {
                                   name = "selenium-server-standalone-2.39.0";
                                   version = "2.39.0";
                                   src = pkgs.fetchurl {
                                      url = "http://selenium-release.storage.googleapis.com/2.39/selenium-server-standalone-2.39.0.jar";
                                      sha256 = "ae9845ccfb10135fd0dcdd70abc79eed147fec685a73a4b6507126577a813d86";
                                      };
      } );
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
