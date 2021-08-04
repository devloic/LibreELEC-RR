# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="slang-shaders-lr"
PKG_VERSION="543422668da610488639308103e0484279bee328"
PKG_SHA256="7a7647c46bb23f9e002a584dc3c6cfe8d9de08c38233838843f606f5de49fc40"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/slang-shaders"
PKG_URL="https://github.com/libretro/slang-shaders/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="gcc:host"
PKG_LONGDESC="Vulkan GLSL RetroArch shader system"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}
  make install INSTALLDIR="${INSTALL}/usr/share/retroarch/shaders/Vulkan-Shaders"
}
