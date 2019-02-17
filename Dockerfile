FROM nixos/nix

LABEL maintainer="Samuel Dionne-Riel <samuel@dionne-riel.com>"
LABEL com.github.actions.name="nix-build"
LABEL com.github.actions.description="A pre-configured action calling nix-build on release.nix, default.nix, or with given arguments."
LABEL com.github.actions.icon="aperture"
LABEL com.github.actions.color="blue"

# Defaults to a fresh nixos-unstable
# Override using an action environment variable
ENV NIX_PATH nixpkgs=channel:nixos-unstable

COPY "entrypoint.sh" "/entrypoint.sh"
COPY "copy-from-store.sh" "/copy-from-store.sh"

ENTRYPOINT ["/entrypoint.sh"]
