# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="melonds"
PKG_VERSION="5e52c245fb38cabe881fbfa6513280ee44fc5bd8"
PKG_SHA256="a487a18d1a39b24d2f339816155054f24532bbaa25a6c39af5feb88fde5afb6a"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/libretro/melonDS"
PKG_URL="https://github.com/libretro/melonDS/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain glibc libpcap"
PKG_LONGDESC="DS emulator, sorta"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto -sysroot"

PKG_LIBNAME="melonds_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="GIT_VERSION=${PKG_VERSION:0:7} platform=unix"

configure_package() {
  # OpenGL Support
  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGL}"
  fi

  # OpenGLES Support
  if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  fi
}

pre_configure_target() {
  # Fix build path
  cd ${PKG_BUILD}

  if target_has_feature neon; then
    PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=1"
  fi

  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    PKG_MAKE_OPTS_TARGET+=" HAVE_OPENGL=1"
  fi

  if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
    PKG_MAKE_OPTS_TARGET+=" HAVE_OPENGLES3=1"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
