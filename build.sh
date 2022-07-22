#!/bin/bash

rm -rf .opk_data
cp -r platform/opendingux/data .opk_data

SAVEDPATH=$PATH
export PATH=/opt/gcw0-toolchain/mipsel-gcw0-linux-uclibc/bin/:/opt/gcw0-toolchain/usr/mipsel-gcw0-linux-uclibc/sysroot/usr/bin:/opt/gcw0-toolchain/usr/bin:/opt/gcw0-toolchain/usr/sbin:$PATH
export CC=/opt/gcw0-toolchain/usr/bin/mipsel-linux-gcc
./configure --platform=opendingux
make -f Makefile
cp PicoDrive .opk_data/PicoDrive_gcw0
strip .opk_data/PicoDrive_gcw0
make -f Makefile clean
export PATH=$SAVEDPATH
export PATH=/opt/lepus-toolchain/mipsel-lepus-linux-musl/bin/:/opt/lepus-toolchain/usr/mipsel-lepus-linux-musl/sysroot/usr/bin:/opt/lepus-toolchain/usr/bin:/opt/lepus-toolchain/usr/sbin:$PATH
export CC=/opt/lepus-toolchain/usr/bin/mipsel-linux-gcc
./configure --platform=opendingux
make -f Makefile
cp PicoDrive .opk_data/PicoDrive_lepus
strip .opk_data/PicoDrive_lepus
export PATH=$SAVEDPATH

mksquashfs .opk_data picodrive.opk -all-root -noappend -no-exports -no-xattrs
