# webdriver-nixos-haskell-example

# Status (Working)

Finally got this working after specifying the chrome path and the other previous changes. Just have to start up selenium server first in a nix-shell with:

```
java -jar /nix/store/88d05cqa56p4dk0dp0v91jjvh0kf9rdw-selenium-server-standalone-2.53.0/share/lib/selenium-server-standalone-2.53.0/selenium-server-standalone-2.53.0.jar -Dwebdriver.chrome.driver=/nix/store/285lapwgrwl4pnay19f82bsxi1d43fnw-chromedriver-2.31/bin/chromedriver -browser "browserName=chrome,version=66.0.3359.139,platform=LINUX"
```

Then within a nix-shell you can:

```
cabal run
```

Alternatively for development you can use:

```
cabal repl
```

# Older Status

command:

```
java -jar /nix/store/88d05cqa56p4dk0dp0v91jjvh0kf9rdw-selenium-server-standalone-2.53.0/share/lib/selenium-server-standalone-2.53.0/selenium-server-standalone-2.53.0.jar -Dwebdriver.chrome.driver=/nix/store/285lapwgrwl4pnay19f82bsxi1d43fnw-chromedriver-2.31/bin/chromedriver -browser "browserName=chrome,version=66.0.3359.139,platform=LINUX"
```

error:

19:58:29.034 WARN - Exception: unknown error: cannot find Chrome binary
  (Driver info: chromedriver=2.31.488763 (092de99f48a300323ecf8c2a4e2e7cab51de5ba8),platform=Linux 4.9.86 x86_64) (WARNING: The server 

# Older Status

Trying to get a simple webdriver example working using the webdriver package from hackage and native packages selenium-server-standalone and chromeDriver.

error:

```
19:37:01.839 INFO - Default driver org.openqa.selenium.chrome.ChromeDriver registration is skipped: registration capabilities Capabilit
ies [{browserName=chrome, version=, platform=ANY}] does not match with current platform: LINUX                                        
```

Oh how do I register the chromeDriver capability?

Let's look at contents of /nix/store/skb6f5vi7hw4nsa5la93sw03wz8zaczv-selenium-server-standalone-2.39.0/bin/selenium-server                                       

```
#! /nix/store/jgw8hxx7wzkyhb2dr9hwsd9h2caaasdc-bash-4.4-p12/bin/bash -e
exec "/nix/store/5j684485jngz1ws3cdamslss2jss2xln-openjdk-8u172b02-jre/bin/java"  -cp /nix/store/c0znmi0ig46lv9qmbykclvwy7hcpympv-htmlunit-driver-standalone-2.21/share/lib/htmlunit-driver-standalone-2.21/htmlunit-driver-standalone-2.21.jar:/nix/store/skb6f5vi7hw4nsa5la93sw03wz8zaczv-selenium-server-standalone-2.39.0/share/lib/selenium-server-standalone-2.53.0/selenium-server-standalone-2.53.0.jar -Dwebdriver.chrome.driver=/nix/store/285lapwgrwl4pnay19f82bsxi1d43fnw-chromedriver-2.31/bin/chromedriver org.openqa.grid.selenium.GridLauncher "${extraFlagsArray[@]}" "$@"
```

That should be fine I think? Wait do I actually have chrome installed? Well I do for sure now. But error still persists.

It isn't seeming to register chromedriver:

```
19:44:57.185 INFO - Default driver org.openqa.selenium.safari.SafariDriver registration is skipped: registration capabilities Capabilit
ies [{browserName=safari, version=, platform=MAC}] does not match with current platform: LINUX                                        
19:44:57.185 INFO - Default driver org.openqa.selenium.chrome.ChromeDriver registration is skipped: registration capabilities Capabilit
ies [{browserName=chrome, version=, platform=ANY}] does not match with current platform: LINUX                                        
```


Apparently we can pass in a `-browser` argument like:

```
-browser "browserName=firefox,version=10.0.12,platform=LINUX"
```

Nix uses chromium 66.0.3359.139 so it'd be:

```
-browser "browserName=chrome,version=66.0.3359.139,platform=LINUX"
```

```
java -jar /nix/store/88d05cqa56p4dk0dp0v91jjvh0kf9rdw-selenium-server-standalone-2.53.0/share/lib/selenium-server-standalone-2.53.0/selenium-server-standalone-2.53.0.jar -Dwebdriver.chrome.driver=/nix/store/285lapwgrwl4pnay19f82bsxi1d43fnw-chromedriver-2.31/bin/chromedriver -browser "browserName=chrome,version=66.0.3359.139,platform=LINUX"
```


# Older Status

I've been working under the assumption that the haskell webdriver bindings autostart the selenium server but that doesn't make sense.

So searched and found the jars:

```
nix/store/88d05cqa56p4dk0dp0v91jjvh0kf9rdw-selenium-server-standalone-2.53.0/bin/selenium-server
/nix/store/88d05cqa56p4dk0dp0v91jjvh0kf9rdw-selenium-server-standalone-2.53.0/share/lib/selenium-server-standalone-2.53.0
/nix/store/88d05cqa56p4dk0dp0v91jjvh0kf9rdw-selenium-server-standalone-2.53.0/share/lib/selenium-server-standalone-2.53.0/selenium-server-standalone-2.53.0.jar
/nix/store/1lardhpdd4ddgz96xin9df3wjm4564b9-selenium-server-standalone-2.53.1
/nix/store/1lardhpdd4ddgz96xin9df3wjm4564b9-selenium-server-standalone-2.53.1/bin/selenium-server
/nix/store/1lardhpdd4ddgz96xin9df3wjm4564b9-selenium-server-standalone-2.53.1/share/lib/selenium-server-standalone-2.53.0
/nix/store/1lardhpdd4ddgz96xin9df3wjm4564b9-selenium-server-standalone-2.53.1/share/lib/selenium-server-standalone-2.53.0/selenium-server-standalone-2.53.0.jar
/nix/store/za0p558li07d94grz0p9lwx9xyxjfw6v-selenium-server-standalone-2.43.1
/nix/store/za0p558li07d94grz0p9lwx9xyxjfw6v-selenium-server-standalone-2.43.1/bin/selenium-server
/nix/store/za0p558li07d94grz0p9lwx9xyxjfw6v-selenium-server-standalone-2.43.1/share/lib/selenium-server-standalone-2.53.0
/nix/store/za0p558li07d94grz0p9lwx9xyxjfw6v-selenium-server-standalone-2.43.1/share/lib/selenium-server-standalone-2.53.0/selenium-server-standalone-2.53.0.jar
/nix/store/skb6f5vi7hw4nsa5la93sw03wz8zaczv-selenium-server-standalone-2.39.0
/nix/store/skb6f5vi7hw4nsa5la93sw03wz8zaczv-selenium-server-standalone-2.39.0/bin/selenium-server
/nix/store/skb6f5vi7hw4nsa5la93sw03wz8zaczv-selenium-server-standalone-2.39.0/share/lib/selenium-server-standalone-2.53.0
/nix/store/skb6f5vi7hw4nsa5la93sw03wz8zaczv-selenium-server-standalone-2.39.0/share/lib/selenium-server-standalone-2.53.0/selenium-server-standalone-2.53.0.jar

```

Will add java and start one of those up.

# Older Status

Apparently [hs-webdriver](https://github.com/kallisti-dev/hs-webdriver/issues/126) has a bug it looks like... or there was a change in seleniums api before 2.39.0

https://github.com/kallisti-dev/hs-webdriver/issues/126#issuecomment-386928303


curl -O http://selenium-release.storage.googleapis.com/2.39/selenium-server-standalone-2.0.0.jar

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



