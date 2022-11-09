# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="scummvm"
PKG_VERSION="7cf738d27095c072c253bef45445e63f708a5441" # v2.6.1
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/SupervisedThinking/scummvm"
PKG_URL="https://github.com/SupervisedThinking/scummvm.git"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="ScummVM is an interpreter for point-and-click adventure games that can be used as a libretro core."
PKG_TOOLCHAIN="make"
PKG_GIT_CLONE_BRANCH="branch-2-6-1-libretro"
PKG_GIT_CLONE_SINGLE="yes"
GET_HANDLER_SUPPORT="git"
PKG_BUILD_FLAGS="-sysroot +speed"

PKG_LIBNAME="scummvm_libretro.so"
PKG_LIBPATH="backends/platform/libretro/build/${PKG_LIBNAME}"

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
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
  mkdir -p ${INSTALL}/usr/share/retroarch/system
    cp -v ${PKG_BUILD}/backends/platform/libretro/aux-data/scummvm.zip ${INSTALL}/usr/share/retroarch/system/
}
