# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-scummvm"
PKG_VERSION="2.6.1-libretro"
PKG_SHA256="7a3fb7fa744e6326b65b2383adcc1935a7b1cf4eafd565bbdb9e1228c58e8b79"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/SupervisedThinking/scummvm"
PKG_URL="https://github.com/SupervisedThinking/scummvm/releases/download/v${PKG_VERSION}/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.scummvm: scummvm for Kodi"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+speed"

PKG_LIBNAME="scummvm_libretro.so"
PKG_LIBPATH="backends/platform/libretro/build/${PKG_LIBNAME}"
PKG_LIBVAR="SCUMMVM_LIB"

PKG_MAKE_OPTS_TARGET="-C backends/platform/libretro/build GIT_VERSION=${PKG_VERSION:0:7}"

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
  # Rebuild ScummVM auxiliary data
  if [ -f ${PKG_BUILD}/backends/platform/libretro/aux-data/scummvm.zip ]; then
    echo -e "\n### Rebuild ScummVM auxiliary data ####\n"
    cd ${PKG_BUILD}/backends/platform/libretro/aux-data
    ./bundle_aux_data.bash
  fi

  # Fix build path
  cd ${PKG_BUILD}

  if [ ! "${ARCH}" = "x86_64" ]; then
    CXXFLAGS+=" -DHAVE_POSIX_MEMALIGN=1"
  fi
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
