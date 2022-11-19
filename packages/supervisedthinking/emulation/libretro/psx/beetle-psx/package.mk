# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="beetle-psx"
PKG_VERSION="f8a904ef5be34ba0b28fabf1b90325d37b321603"
PKG_SHA256="c930ac00ad651e5307fa68726e75d2ff5db4cb02c513e839772d7d43383eae4f"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/beetle-psx-libretro"
PKG_URL="https://github.com/libretro/beetle-psx-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Standalone port/fork of Mednafen PSX to the Libretro API."
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="+lto -sysroot"

PKG_LIBNAME="mednafen_psx_*libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

configure_package() {
  # Displayserver Support
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_DEPENDS_TARGET+=" xorg-server"
  fi

  # OpenGL Support
  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGL}"
  fi
}

make_target() {
  # Common make opts
  PKG_MAKE_OPTS_TARGET="GIT_VERSION=${PKG_VERSION:0:7} LINK_STATIC_LIBCPLUSPLUS=0"

  # Build beetle-psx software renderer
  echo "Executing (target): make ${PKG_MAKE_OPTS_TARGET}" | tr -s " "
  make ${PKG_MAKE_OPTS_TARGET}

  # Build beetle-psx with OpenGL/Vulkan support if available
  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    mkdir -p tmp
    mv ${PKG_LIBNAME} tmp/
    make clean
    if [ "${VULKAN_SUPPORT}" = "yes" ]; then
      PKG_MAKE_OPTS_TARGET+=" HAVE_HW=1"
    else
      PKG_MAKE_OPTS_TARGET+=" HAVE_OPENGL=1"
    fi
    echo "Executing (target): make ${PKG_MAKE_OPTS_TARGET}" | tr -s " "
    make ${PKG_MAKE_OPTS_TARGET}
    mv tmp/${PKG_LIBNAME} .
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
