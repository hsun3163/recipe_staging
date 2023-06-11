#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

cargo-bundle-licenses \
    --format yaml \
    --output THIRDPARTY.yml

export SODIUM_USE_PKG_CONFIG=1
cargo install --locked --root "${PREFIX}" --path atuin

install -Dd ${PREFIX}/etc/bash_completion.d ${PREFIX}/share/fish/vendor_completions.d ${PREFIX}/share/zsh/site-functions
atuin gen-completion --shell bash --out-dir ${PREFIX}/etc/bash_completion.d/atuin
atuin gen-completion --shell zsh --out-dir ${PREFIX}/share/zsh/site-functions/_atuin
atuin gen-completion --shell fish --out-dir ${PREFIX}/share/fish/vendor_completions.d/atuin.fish

# strip debug symbols
"${STRIP}" "${PREFIX}/bin/atuin"

# remove extra build file
rm -f "${PREFIX}/.crates.toml"
