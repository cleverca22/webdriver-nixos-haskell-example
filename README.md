# webdriver-nixos-haskell-example


Trying to get a simple webdriver example working using the webdriver package from hackage and native packages selenium-server-standalone and chromeDriver.

I'm currently stuck on this issue:

```
[cody@nixos:~/source/webdriver-nixos-haskell-example]$ nix-shell
error: ‘f’ at /home/cody/source/webdriver-nixos-haskell-example/shell.nix:7:7 called without required argument ‘chromeDriver’, at /nix/store/wj9akm9hbpqk4ihwcpysvksgvm3z1i0n-nixos-17.09.3142.e02a9ba3670/nixos/pkgs/development/haskell-modules/make-package-set.nix:87:27
```

I'm trying to base it upon the example given here: https://github.com/Gabriel439/haskell-nix/tree/master/project2 with the difference that I used `cabal2nix --shell . > shell.nix`.

I believe it's because of this line

```
drv = variant (haskellPackages.callPackage f {});
```

haskellPackages.callPackage is not calling with executableSystemDepends, but the definition of f requires it to be there.

I'm not sure how to fix it right now
