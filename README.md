# webdriver-nixos-haskell-example


Trying to get a simple webdriver example working using the webdriver package from hackage and native packages selenium-server-standalone and chromeDriver.


# Status

Apparently [hs-webdriver](https://github.com/kallisti-dev/hs-webdriver/issues/126) has a bug it looks like... or there was a change in seleniums api before 2.39.0

https://github.com/kallisti-dev/hs-webdriver/issues/126#issuecomment-386928303

# Older Status

Asked on #NixOs and was told to use OverrideAttrs. looked up this example in nixpkgs manual at https://nixos.org/nixpkgs/manual/#sec-pkg-overrideAttrs

helloWithDebug = pkgs.hello.overrideAttrs (oldAttrs: rec {
    separateDebugInfo = true;
});

That worked, but selenium 2.53.1 also had the bug.. trying older 2.43.1 version. I know at some point I used this package and it worked.


# Older Status

Tried overriding name/version/src but got:

```
[cody@nixos:~/source/webdriver-nixos-haskell-example]$ !!
nix-shell
error: anonymous function at /nix/store/wj9akm9hbpqk4ihwcpysvksgvm3z1i0n-nixos-17.09.3142.e02a9ba3670/nixos/pkgs/development/tools/selenium/server/default.nix:1:1 called with unexpected argument ‘src’, at /nix/store/wj9akm9hbpqk4ihwcpysvksgvm3z1i0n-nixos-17.09.3142.e02a9ba
3670/nixos/lib/customisation.nix:74:12                                                                                                                                                                                                                                          
(use ‘--show-trace’ to show detailed location information)
```

Does [the selenium-server-standalone derivation](https://github.com/NixOS/nixpkgs/blob/b0dac30ab552a59b772b4fe34c494b107fce01e5/pkgs/development/tools/selenium/server/default.nix#L14) not allow overriding? I see it uses mkDerivation but I don't see makeOverrideable used anywhere... is it necessary for me to be able to override something?

# Older Status

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

Also looking at https://nixos.org/nixpkgs/manual/#sec-modify-via-packageOverrides now:

```
{
  packageOverrides = pkgs: rec {
    foo = pkgs.foo.override { ... };
  };
}

```

Okay... so let's search for selenium-server-standalone here: https://nixos.org/nixos/packages.html#selenium and find the source for it is here:

https://github.com/NixOS/nixpkgs/blob/b0dac30ab552a59b772b4fe34c494b107fce01e5/pkgs/development/tools/selenium/server/default.nix#L37

Looks like I can just override minorVersion and patchVersion as soon as I find what's available.

Newest is: selenium-server-standalone-2.53.1.jar

So let's try this:

```
{
  packageOverrides = pkgs: rec {
    selenium-server-standalone = pkgs.selenium-server-standalone.override { majorVersion = 2.53; minorVersion = 1; };
  };
}
```



