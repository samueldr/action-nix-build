FROM nixos/nix

RUN nix-channel --add https://nixos.org/channels/nixos-unstable nixpkgs
RUN nix-channel --update

COPY "entrypoint.sh" "/entrypoint.sh"

ENTRYPOINT ["/entrypoint.sh"]
