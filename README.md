# webdriver-nixos-haskell-example


Trying to get a simple webdriver example working using the webdriver package from hackage and native packages selenium-server-standalone and chromeDriver.

# Status

error:

```
*** Exception: HttpExceptionRequest Request {
  host                 = "127.0.0.1"
  port                 = 4444
  secure               = False
  requestHeaders       = [("Accept","application/json;charset=UTF-8"),("Content-Type","application/json;charset=UTF-8")]
  path                 = "/wd/hub/session"
  queryString          = ""
  method               = "POST"
  proxy                = Nothing
  rawBody              = False
  redirectCount        = 10
  responseTimeout      = ResponseTimeoutDefault
  requestVersion       = HTTP/1.1
}
 (ConnectionFailure Network.Socket.connect: <socket: 11>: does not exist (Connection refused))
```

I need to update the version of selenium I'm using [to use selenium 2 because selenium 3 is unsupported](https://github.com/kallisti-dev/hs-webdriver/issues/126).


Here's an example from [haskell-nix project 3]() where a haskell package is over-ridden:

```
let
  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackgesOld: rec {
          project3 =
            pkgs.haskell.lib.overrideCabal
              ( haskellPackagesNew.callPackage ./default.nix {
                  tar = pkgs.libtar;
                }
              )
              ( oldDerivation: {
                  testToolDepends = [ pkgs.libarchive ];
                }
              );
        };
      };
    };
  };

  pkgs = import <nixpkgs> { inherit config; };

in
  { project3 = pkgs.haskellPackages.project3;
  }
```

I think I can do something similar in shell.nix.
