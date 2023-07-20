#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

cd src
make CC=${CXX}
cd ..

mkdir -p ${PREFIX}/bin
install -m 755 bin/Sanity ${PREFIX}/bin
install -m 755 bin/Sanity_distance ${PREFIX}/bin
