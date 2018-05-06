{ mkDerivation, base, chromeDriver, selenium-server-standalone
, stdenv, webdriver
}:
mkDerivation {
  pname = "webdriver-nixos-haskell-example";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base webdriver ];
  executableSystemDepends = [
    chromeDriver selenium-server-standalone
  ];
  license = stdenv.lib.licenses.bsd3;
}
