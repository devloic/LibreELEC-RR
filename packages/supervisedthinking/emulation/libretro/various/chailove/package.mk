# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="chailove"
PKG_VERSION="9677b142ab9562cb278e87d7475c55fe0b9a4333" # v1.2.1+
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/libretro-chailove"
PKG_URL="https://github.com/libretro/libretro-chailove.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ChaiLove is an awesome framework you can use to make 2D games in ChaiScript."
GET_HANDLER_SUPPORT="git"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto -sysroot"

PKG_LIBNAME="chailove_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="GIT_VERSION=${PKG_VERSION:0:7}"

configure_target() {
  cd ${PKG_BUILD}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
