`nix-build` action
==================

This GitHub Action will run `nix-build`, using the latest
[nixos/nix docker image](https://github.com/NixOS/docker).

It will build one of, in order or preference:

 * `"$@"` if arguments are set
 * `nix-build release.nix` if release.nix exists
 * `nix-build default.nix` if default.nix exists


`/nix/store`
------------

Given that this executes in a single-use Docker container, the Nix store is not
persistent, and will be lost once the action is over.

The results from running `nix-build [release|default].nix` will be
automatically resolved from their symlinks and copied in place in a non-
recursive manner.

This means that `release.nix` is expected to not keep reference to the store if
the result is to be used in a non Nix store aware Action.

### Nix store awareness

Simply put, a nix store aware Action will know to mount an overlayfs over the
nix store and store in the `/github/_nix` Workflow-persistent location.

```
mount -t overlay overlay \
	-olowerdir=/nix/,upperdir=/github/home/_nix,workdir=/github/home/.workdir \
	/nix/
```


Environment
-----------

### Channel

By default, it will use `nixos-unstable` as a channel. This is meant to
keep the action "always up to date" even on new NixOS releases.

To configure another channel, set `NIX_PATH` accordingly

```
action "samueldr/action-nix-build@master" {
  uses = "samueldr/action-nix-build@master"
  env = {
    NIX_PATH = "nixpkgs=channel:nixos-18.09"
  }
}
```

See the [Nix manual](https://nixos.org/nix/manual/) for more information about
`NIX_PATH`.

### Unfree

The easiest way to handle this is to use the environment variable that Nixpkgs
looks at.

```
action "samueldr/action-nix-build@master" {
  uses = "samueldr/action-nix-build@master"
  env = {
    NIXPKGS_ALLOW_UNFREE = "1"
  }
}
```

