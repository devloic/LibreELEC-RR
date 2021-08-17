# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="dosbox-pure"
PKG_VERSION="0.15"
PKG_SHA256="2b696724bc743aea7f3c31c6eb0ae86d87698da1d8d54ce593612f17bb644813"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/schellingb/dosbox-pure"
PKG_URL="https://github.com/schellingb/dosbox-pure/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="DOSBox Pure is a fork of DOSBox, an emulator for DOS games, built for RetroArch/Libretro aiming for simplicity and ease of use."
PKG_BUILD_FLAGS="+lto +speed -sysroot"

PKG_LIBNAME="dosbox_pure_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
