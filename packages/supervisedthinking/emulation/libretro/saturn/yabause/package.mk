# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="yabause"
PKG_VERSION="c7e02721eddb3de0ec7ae0d61e9e3afa5f586a62"
PKG_SHA256="bcca900ed7c5721d56b09d4c8efb97d1fbae29ace0b40a2c0fbe232ba1c79b47"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/yabause"
PKG_URL="https://github.com/libretro/yabause/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Yabause is a Sega Saturn emulator."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto -sysroot"

PKG_LIBNAME="yabause_libretro.so"
PKG_LIBPATH="yabause/src/libretro/${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="-C yabause/src/libretro GIT_VERSION=${PKG_VERSION:0:7}"

pre_configure_target() {
  if [ "${ARCH}" = "arm" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=armv"
    # ARM NEON support
    if target_has_feature neon; then
      PKG_MAKE_OPTS_TARGET+="-neon"
    fi
    PKG_MAKE_OPTS_TARGET+="-${TARGET_FLOAT}float-${TARGET_CPU}"
  fi
}

pre_make_target() {
  make CC=${HOST_CC} -C yabause/src/libretro generate-files
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
