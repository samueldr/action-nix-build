#!/bin/sh

set -e

# Ensures the nix store is kept between runs of nix-aware helpers.
mount -t overlay overlay \
	-olowerdir=/nix/,upperdir=/github/_nix,workdir=/github/_workdir \
	/nix/

if [ $# -gt 0 ]; then
	"$@"
elif [ -e release.nix ]; then
	nix-build ./release.nix
elif [ -e default.nix ]; then
	nix-build ./default.nix
else
	echo "Nothing to build, either add release.nix or default.nix at the root, or give arguments to nix-build."
	exit 1
fi

# As this is `busybox find` it `-lname /nix/*` cannot be used.
find . -type l -exec '/copy-from-store.sh' '{}' ';'
