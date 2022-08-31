# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="cemu"
PKG_VERSION="d23bbd7d9a6cc2aedbe29bbfca358f59f6b049cf" #v2.0+
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/cemu-project/Cemu"
PKG_URL="https://github.com/SupervisedThinking/Cemu.git"
PKG_DEPENDS_TARGET="toolchain imgui libzip-system glslang"
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

  sed -e "s#glm::glm#glm#" -i ${PKG_BUILD}/src/{Common,input}/CMakeLists.txt
  sed -i 's/GLSLANG_VERSION_LESS_OR_EQUAL_TO/GLSLANG_VERSION_GREATER_OR_EQUAL_TO/' -i ${PKG_BUILD}/src/Cafe/HW/Latte/Renderer/Vulkan/RendererShaderVk.cpp
}
