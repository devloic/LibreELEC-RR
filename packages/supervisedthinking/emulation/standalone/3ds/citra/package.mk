# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="citra"
PKG_VERSION="84e54a52a6402928f0cda4bbce24d930546f9842" #nightly r1830
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://citra-emu.org/"
PKG_URL="https://github.com/citra-emu/citra-nightly.git"
PKG_DEPENDS_TARGET="toolchain linux glibc systemd dbus zlib pulseaudio ffmpeg mesa xorg-server boost-system qt5 sdl2 unclutter-xfixes"
PKG_LONGDESC="Citra is an experimental open-source Nintendo 3DS emulator/debugger written in C++"
GET_HANDLER_SUPPORT="git"
PKG_GIT_CLONE_BRANCH="master"
PKG_GIT_CLONE_SINGLE="yes"
PKG_BUILD_FLAGS="+gold"

configure_package() {
  # Add fdk-aac for HLE AAC decoding support
  if [ "${NON_FREE_PKG_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" fdk-aac"
  fi
}

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-D ENABLE_LTO=ON \
                         -D ENABLE_SDL2=ON \
                         -D USE_SYSTEM_SDL2=ON \
                         -D ENABLE_QT=ON \
                         -D ENABLE_WEB_SERVICE=OFF \
                         -D ENABLE_CUBEB=ON \
                         -D ENABLE_FFMPEG_AUDIO_DECODER=ON \
                         -D ENABLE_FFMPEG_VIDEO_DUMPER=ON \
                         -D USE_DISCORD_PRESENCE=OFF \
                         -D USE_SYSTEM_BOOST=ON \
                         -Wno-dev"

  # Conditionally enable HLE AAC decoding support
  if [ "${NON_FREE_PKG_SUPPORT}" = "yes" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -D ENABLE_FDK=ON"
  else
    PKG_CMAKE_OPTS_TARGET+=" -D ENABLE_FFMPEG_AUDIO_DECODER=ON"
  fi
}

pre_make_target() {
  # fix cross compiling
  find ${PKG_BUILD} -name flags.make -exec sed  -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

post_makeinstall_target() {
  # Copy scripts & config files
  mkdir -p ${INSTALL}/usr/config/citra-emu
  cp -a  ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin/
  cp -PR ${PKG_DIR}/config/*  ${INSTALL}/usr/config/citra-emu/
  cp -PR ${PKG_DIR}/files/*   ${INSTALL}/usr/config/citra-emu/
  
  # Clean up
  safe_remove ${INSTALL}/usr/share/
  safe_remove ${INSTALL}/usr/bin/citra
}
