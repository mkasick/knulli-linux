#!/bin/bash

set -ex

make "$@" h700-build || true
make "$@" h700_armhf_libs-build
for i in {,usr/}lib; do cp -al "output/h700_armhf_libs/target/$i" "output/h700/target/${i}32"; done
ln -sf ../lib32/ld-linux-armhf.so.3 output/h700/target/lib/
printf "%s\n" /{,usr/}lib32 > output/h700/target/etc/ld.so.conf
make h700-shell CMD='host/bin/qemu-aarch64 target/sbin/ldconfig -r target'
make "$@" h700-build
