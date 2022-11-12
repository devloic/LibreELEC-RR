# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="mame2003-plus"
PKG_VERSION="6bdb7be5ecd1ae0468a6287f46e2034d97460e7b"
PKG_SHA256="f5eb7973bb22349f36251aea660869e682c6b018b918b801631a8927fc125e70"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/mame2003-plus-libretro"
PKG_URL="https://github.com/libretro/mame2003-plus-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Updated 2018 version of MAME (0.78) for libretro. with added game support plus many fixes and improvements"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto -sysroot"

PKG_LIBNAME="mame2003_plus_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="GIT_VERSION=${PKG_VERSION:0:7}"

pre_configure_target() {
  if [ "${ARCH}" = "arm" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=armv"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}

post_makeinstall_target() {
  # Copy metadata for manual content scanning
  mkdir -p ${INSTALL}/usr/share/retroarch/database/mame2003-plus
    cp -v ${PKG_BUILD}/metadata/mame2003-plus.xml ${INSTALL}/usr/share/retroarch/database/mame2003-plus

  mkdir -p ${INSTALL}/usr/share/retroarch/bios/mame2003-plus/samples
    cp -v ${PKG_BUILD}/metadata/artwork/*.zip               ${INSTALL}/usr/share/retroarch/bios/mame2003-plus
    cp -v ${PKG_BUILD}/metadata/{cheat,hiscore,history}.dat ${INSTALL}/usr/share/retroarch/bios/mame2003-plus
    # Something must be in a folder in order to include it in the image, so why not some instructions
    echo "Put your samples here." > ${INSTALL}/usr/share/retroarch/bios/mame2003-plus/samples/readme.txt
}