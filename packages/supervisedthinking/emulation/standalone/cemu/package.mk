# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="cemu"
PKG_VERSION="c78b3da872439fda2775d43bf1b921d72a4bee40" #v2.0-19+
PKG_ARCH="x86_64"
PKG_LICENSE="MPL-2.0"
PKG_SITE="https://github.com/cemu-project/Cemu"
PKG_URL="https://github.com/cemu-project/Cemu.git"
PKG_DEPENDS_TARGET="toolchain libzip-system glslang glm curl rapidjson openssl boost-system libfmt pugixml-system libpng wxwidgets"
PKG_LONGDESC="Cemu is a Wii U emulator that is able to run most Wii U games and homebrew in a playable state"
PKG_GIT_CLONE_BRANCH="main"
PKG_GIT_CLONE_SINGLE="yes"
GET_HANDLER_SUPPORT="git"
PKG_BUILD_FLAGS+=" +lto"

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

  # Vulkan Support
  if [ "${VULKAN_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${VULKAN}"
  fi
}

pre_configure_target() {
  # Force build of cubeb submodule
  sed -e '/find_package(cubeb)/d' -i ${PKG_BUILD}/CMakeLists.txt
  # Fix glm linking
  sed -e "s#glm::glm#glm#" -i ${PKG_BUILD}/src/{Common,input}/CMakeLists.txt

  PKG_CMAKE_OPTS_TARGET="-D ENABLE_VCPKG=OFF \
                         -D PORTABLE=OFF \
                         -D ENABLE_DISCORD_RPC=OFF \
                         -D ENABLE_SDL=ON \
                         -D ENABLE_CUBEB=ON \
                         -D ENABLE_WXWIDGETS=ON \
                         -Wno-dev"

  # Wayland Support
  if [ "${DISPLAYSERVER}" = "wl" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -D ENABLE_WAYLAND=ON"
  else
    PKG_CMAKE_OPTS_TARGET+=" -D ENABLE_WAYLAND=OFF"
  fi

  # OpenGL Support
  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -D ENABLE_OPENGL=ON"
  else
    PKG_CMAKE_OPTS_TARGET+=" -D ENABLE_OPENGL=OFF"
  fi

  # Vulkan Support
  if [ "${VULKAN_SUPPORT}" = "yes" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -D ENABLE_VULKAN=ON"
  else
    PKG_CMAKE_OPTS_TARGET+=" -D ENABLE_VULKAN=OFF"
  fi
}

makeinstall_target() {
  # Copy binary, scripts & config files
  mkdir -p ${INSTALL}/usr/bin
    cp -v ${PKG_BUILD}/bin/Cemu_* ${INSTALL}/usr/bin/cemu
    cp -v ${PKG_DIR}/scripts/*    ${INSTALL}/usr/bin/

  mkdir -p ${INSTALL}/usr/config/Cemu
    cp -PR ${PKG_DIR}/config/* ${INSTALL}/usr/config/Cemu

  # Copy system files
  mkdir -p ${INSTALL}/usr/share/Cemu
    cp -PR ${PKG_BUILD}/bin/{gameProfiles,resources} ${INSTALL}/usr/share/Cemu
}
