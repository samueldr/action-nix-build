`nix-build` action
==================

This GitHub Action will run `nix-build`, using the latest
[nixos/nix docker image](https://github.com/NixOS/docker).

It will build one of, in order or preference:

 * `nix-build "$@"` if arguments are set
 * `nix-build release.nix` if release.nix exists
 * `nix-build release.nix` if default.nix exists

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

