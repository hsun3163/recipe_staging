#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

cargo-bundle-licenses \
    --format yaml \
    --output THIRDPARTY.yml

# build statically linked binary with Rust
cargo install --locked --root ${PREFIX} --path crates/cli
mkdir -p ${PREFIX}/share/man/man1
install -m 644 doc/watchexec.1 ${PREFIX}/share/man/man1/watchexec.1

# strip debug symbols
"$STRIP" "$PREFIX/bin/${PKG_NAME}"

# remove extra build file
rm -f "${PREFIX}/.crates.toml"