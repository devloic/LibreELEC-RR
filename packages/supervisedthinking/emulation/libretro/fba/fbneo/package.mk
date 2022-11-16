# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="fbneo"
PKG_VERSION="c5f7b020c3a2bbe34bcdb15a4700a4c8d1b7b2e3"
PKG_SHA256="487b22e41998f67fc29254c90901e9de7adfea8bf21929ac018a30b2bde920ce"
PKG_LICENSE="OSS"
PKG_SITE="https://github.com/libretro/FBNeo"
PKG_URL="https://github.com/libretro/FBNeo/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A libretro port of FinalBurn Neo for Romset v1.0.0.02"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-gold +lto -sysroot"

PKG_LIBNAME="fbneo_libretro.so"
PKG_LIBPATH="src/burner/libretro/${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="-C src/burner/libretro/ GIT_VERSION=${PKG_VERSION:0:7}"

pre_configure_target() {
  if [ "${ARCH}" = "arm" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=armv"

    # ARM NEON Support
    if target_has_feature neon; then
      PKG_MAKE_OPTS_TARGET+="-neon"
    fi
  fi

  # libretro-fbneo does not need / nor build successfully with _FILE_OFFSET_BITS or _TIME_BITS set
  if [ "${TARGET_ARCH}" = "arm" ]; then
    export CFLAGS=$(echo ${CFLAGS} | sed -e "s|-D_FILE_OFFSET_BITS=64||g")
    export CFLAGS=$(echo ${CFLAGS} | sed -e "s|-D_TIME_BITS=64||g")
    export CXXFLAGS=$(echo ${CXXFLAGS} | sed -e "s|-D_FILE_OFFSET_BITS=64||g")
    export CXXFLAGS=$(echo ${CXXFLAGS} | sed -e "s|-D_TIME_BITS=64||g")
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}

post_makeinstall_target() {
  # Copy metadata for manual content scanning
  mkdir -p ${INSTALL}/usr/share/retroarch/database/fbneo
    cp ${PKG_BUILD}/dats/*.dat ${INSTALL}/usr/share/retroarch/database/fbneo

  mkdir -p ${INSTALL}/usr/share/retroarch/bios/fbneo
    cp ${PKG_BUILD}/metadata/hiscore.dat ${INSTALL}/usr/share/retroarch/bios/fbneo
}
