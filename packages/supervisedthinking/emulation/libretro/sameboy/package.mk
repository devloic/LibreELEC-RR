# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="sameboy"
PKG_VERSION="120ada4232cdc63e03a408bfc8e83b96e2ee07d8"
PKG_SHA256="b4dd295d32ecc04adcc202792b415c9802507fb0a9d1abe7da97c73570038764"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/SameBoy"
PKG_URL="https://github.com/libretro/SameBoy/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="Gameboy and Gameboy Color emulator written in C"
PKG_BUILD_FLAGS="+lto -sysroot"

PKG_LIBNAME="sameboy_libretro.so"
PKG_LIBPATH="libretro/${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET=" -C libretro GIT_VERSION=${PKG_VERSION:0:7}"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
