#!/bin/sh

set -e

path="$1"
location="$(readlink -f "$path")"

# Starts with `/nix/store/`?
if [[ "$location" == "${location##/nix/store/}" ]]; then
	echo "Skipping $path -> $location"
else
	rm "$path"
	exec cp -prf "$location" "$path"
fi
