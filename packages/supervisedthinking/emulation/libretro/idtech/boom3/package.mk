# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="boom3"
PKG_VERSION="0bea79abf5ec8262dfe9af73cb8c54ea6e2aeb98"
PKG_SHA256="613d655c7f05dd2fd90fc27721165efad2be6c30ed85d82a07d28d81e30324cc"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/libretro/boom3"
PKG_URL="https://github.com/libretro/boom3/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="dhewm3 port to libretro."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto -sysroot"

PKG_LIBNAME="boom3_libretro.so"
PKG_LIBPATH="neo/${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET=" -C neo GIT_VERSION=${PKG_VERSION:0:7}"

configure_package() {
  # Displayserver Support
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_DEPENDS_TARGET+=" xorg-server"
  fi

  # OpenGL Support
  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGL}"
  fi

  # OpenGLES Support
  if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  fi
}

pre_make_target() {
  cd $PKG_BUILD
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
