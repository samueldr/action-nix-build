#!/bin/sh

if [ $# -gt 0 ]; then
	exec nix-build "$@"
fi

# Defaults to building whatever `release.nix` is.
if [ -e release.nix ]; then
	exec nix-build ./release.nix
elif [ -e default.nix ]; then
	exec nix-build ./default.nix
fi

echo "Nothing to build, either add release.nix or default.nix at the root, or give arguments to nix-build."
exit 1
