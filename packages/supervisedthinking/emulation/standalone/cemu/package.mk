# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="cemu"
PKG_VERSION="723fd8cbef010106bb103594e898a22f6589881c" #v2.0+
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/cemu-project/Cemu"
PKG_URL="https://github.com/cemu-project/Cemu.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Cemu is a Wii U emulator"
PKG_GIT_CLONE_BRANCH="main"
PKG_GIT_CLONE_SINGLE="yes"
GET_HANDLER_SUPPORT="git"

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-D PUBLIC_RELEASE=ON \
                         -D ENABLE_OPENGL=ON \
                         -D ENABLE_VULKAN=ON \
                         -D ENABLE_DISCORD_RPC=OFF \
                         -D ENABLE_SDL=ON \
                         -D ENABLE_CUBEB=ON \
                         -D ENABLE_WXWIDGETS=ON"
}
