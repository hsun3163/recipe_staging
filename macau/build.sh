#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

arc unarchive macau-v${PKG_VERSION}.rar

cd macau-v${PKG_VERSION}
# Delete old binaries
rm macau
rm -rf *.o
if [[ ${target_platform} =~ .*osx.* ]]; then
    make SYS=MAC FORCE_DYNAMIC=1 CPP=${CXX} LIBS_MAC_D_LAPACK="-L${PREFIX}/lib -Wl,-rpath,${PREFIX}/lib -lopenblas" HEADERS=-I${PREFIX}/include
else
    make SYS=LNX FORCE_DYNAMIC=1 CPP=${CXX} LIBS_LNX_D_LAPACK="-L${PREFIX}/lib -Wl,-rpath,${PREFIX}/lib -lopenblas" HEADERS=-I${PREFIX}/include
fi

mkdir -p ${PREFIX}/bin
install -m 755 macau ${PREFIX}/bin
