# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="puae"
PKG_VERSION="f583dc32e111ed88658d3e3df78055e347620a6f"
PKG_SHA256="58d343f5ad29ee63716e5af16077f2c163f41b9f0b90027a306bb3c6aceec9d2"
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
