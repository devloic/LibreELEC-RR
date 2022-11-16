# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="swanstation"
PKG_VERSION="27a224fc9e86e0f061504878d1c0cbf3fd6891af"
PKG_SHA256="5fab45a94ad3f8e8f68ee93bc6c0f12d54560c31e60d1e053cde9ffff9bfd5f8"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/libretro/swanstation"
PKG_URL="https://github.com/libretro/swanstation/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="SwanStation(DuckStation) is an simulator/emulator of the Sony PlayStation(TM) console, focusing on playability, speed, and long-term maintainability."
PKG_BUILD_FLAGS="-sysroot"

configure_package() {
  # Displayserver Support
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_DEPENDS_TARGET+=" xorg-server"
  elif [ "${DISPLAYSERVER}" = "wl" ]; then
    PKG_DEPENDS_TARGET+=" wayland"
  fi

  # OpenGL Support
  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGL}"
  fi

  # OpenGLES Support
  if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  fi

  # Vulkan Support
  if [ "${VULKAN_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${VULKAN}"
  fi

  # Fix LTO
  if [ ! "${ARCH}" = "arm" ]; then
    PKG_BUILD_FLAGS+=" +lto"
  fi
}

PKG_LIBNAME="swanstation_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-D BUILD_NOGUI_FRONTEND=OFF \
                         -D BUILD_QT_FRONTEND=OFF \
                         -D BUILD_LIBRETRO_CORE=ON \
                         -D ENABLE_DISCORD_PRESENCE=OFF \
                         -D USE_SDL2=OFF"

  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -D USE_X11=ON"
  elif [ "${DISPLAYSERVER}" = "wl" ]; then
    PKG_CMAKE_OPTS_TARGET+="  -D USE_X11=OFF \
                              -D USE_WAYLAND=ON"
  else
    PKG_CMAKE_OPTS_TARGET+="  -D USE_X11=OFF \
                              -D USE_DRMKMS=ON"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
