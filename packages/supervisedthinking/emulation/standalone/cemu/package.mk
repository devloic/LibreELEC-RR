# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="cemu"
PKG_VERSION="2c81d240a5b065d8cf4c555754c4bfeaf42c826c" #v2.0-19+
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/cemu-project/Cemu"
PKG_URL="https://github.com/cemu-project/Cemu.git"
PKG_DEPENDS_TARGET="toolchain libzip-system glslang glm curl rapidjson openssl boost-system libfmt pugixml-system libpng wxwidgets"
PKG_LONGDESC="Cemu is a Wii U emulator"
PKG_GIT_CLONE_BRANCH="main"
PKG_GIT_CLONE_SINGLE="yes"
GET_HANDLER_SUPPORT="git"

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-D ENABLE_VCPKG=OFF \
                         -D PORTABLE=OFF \
                         -D ENABLE_OPENGL=ON \
                         -D ENABLE_VULKAN=ON \
                         -D ENABLE_DISCORD_RPC=OFF \
                         -D ENABLE_SDL=ON \
                         -D ENABLE_CUBEB=ON \
                         -D ENABLE_WXWIDGETS=ON \
                         -Wno-dev"
  # Force build of cubeb submodule
  sed -e '/find_package(cubeb)/d' -i ${PKG_BUILD}/CMakeLists.txt
  # Fix glm linking
  sed -e "s#glm::glm#glm#" -i ${PKG_BUILD}/src/{Common,input}/CMakeLists.txt
}

makeinstall_target() {
  # Copy binary, scripts & config files
  mkdir -p ${INSTALL}/usr/bin
    cp -v ${PKG_BUILD}/bin/Cemu_* ${INSTALL}/usr/bin/cemu
    cp -v ${PKG_DIR}/scripts/*    ${INSTALL}/usr/bin/

  mkdir -p ${INSTALL}/usr/config/Cemu
    cp -PR ${PKG_DIR}/config/* ${INSTALL}/usr/config/Cemu

  # Copy system files
  mkdir -p ${INSTALL}/usr/share/Cemu/resources
    cp -PR ${PKG_BUILD}/bin/{gameProfiles,resources} ${INSTALL}/usr/share/Cemu
    cp -PR ${PKG_DIR}/files/*                        ${INSTALL}/usr/share/Cemu/resources
}
