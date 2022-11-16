# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="puae"
PKG_VERSION="1618077ebde376de1638455c19b315de376d90b4"
PKG_SHA256="81e6c97fb929384f68341bea353b5c6f21bcf47a02d9bbd3dbc4b6a6a1d6e8d9"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/libretro-uae"
PKG_URL="https://github.com/libretro/libretro-uae/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain capsimg"
PKG_LONGDESC="Libretro wrapper for UAE emulator."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto +speed -sysroot"

PKG_LIBNAME="puae_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="GIT_VERSION=${PKG_VERSION:0:7}"

pre_configure_target() {
  if [ "${ARCH}" = "arm" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=armv"
    # ARM NEON support
    if target_has_feature neon; then
      PKG_MAKE_OPTS_TARGET+="-neon"
    fi
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/retroarch/bios
    cp -vr ${PKG_BUILD}/sources/uae_data ${INSTALL}/usr/share/retroarch/bios/
}
