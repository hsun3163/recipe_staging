#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

export CI=TRUE
sed "s/version ~=.+?/version := \"${PKG_VERSION}\",/"
