# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="dolphin-libretro"
PKG_VERSION="0df1b5be3be8884522ca15de71deaaa8143d0d09"
PKG_SHA256="fde4b1d97206967456c8b70a9e03b3b861b0c146fd977885194aab5602d84d9d"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/dolphin"
PKG_URL="https://github.com/libretro/dolphin/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain systemd mesa enet-system bluez lzo alsa-lib ffmpeg curl libpng zlib zstd"
PKG_LONGDESC="Dolphin is a GameCube / Wii emulator, allowing you to play games for these two platforms on PC with improvements."
PKG_BUILD_FLAGS="+lto -sysroot"

PKG_LIBNAME="dolphin_libretro.so"
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

  # OpenGLES Support
  if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  fi

  # Vulkan Support
  if [ "${VULKAN_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${VULKAN}"
  fi
}

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=ON \
                         -DUSE_OPENMP=OFF"

  if [ "$OPENGLES_SUPPORT" = yes ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DUSE_GLES=ON"
  fi

  if [ "$VULKAN_SUPPORT" = yes ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DUSE_VULKAN=ON"
  fi
}

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-D USE_SHARED_ENET=on \
                         -D ENABLE_NOGUI=OFF \
                         -D ENABLE_QT=OFF \
                         -D ENABLE_LTO=OFF \
                         -D USE_DISCORD_PRESENCE=OFF \
                         -D ENABLE_TESTS=OFF \
                         -D LIBRETRO=ON"

  if [ "${DISPLAYSERVER}" != "x11" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -D ENABLE_X11=OFF"
  fi
}

pre_make_target() {
  # fix cross compiling
  find ${PKG_BUILD} -name flags.make -exec sed  -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/retroarch/bios/dolphin-emu
    cp -vr ${PKG_BUILD}/Data/Sys ${INSTALL}/usr/share/retroarch/bios/dolphin-emu/
}
