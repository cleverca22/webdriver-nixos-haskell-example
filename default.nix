{ mkDerivation, base, chromedriver, selenium-server-standalone
, stdenv, webdriver, jdk, chromium
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
}
