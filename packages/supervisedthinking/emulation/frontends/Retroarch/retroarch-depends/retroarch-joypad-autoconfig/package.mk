# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="retroarch-joypad-autoconfig"
PKG_VERSION="1.9.5"
PKG_SHA256="6255d94b52ae6ab770f7a4247b48f5c4e566d3aa441546375fdf788dd089d376"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/retroarch-joypad-autoconfig"
PKG_URL="https://github.com/libretro/retroarch-joypad-autoconfig/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="gcc:host"
PKG_LONGDESC="RetroArch joypad autoconfig files"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}
  make install INSTALLDIR="${INSTALL}/usr/share/retroarch/autoconfig" DOC_DIR="${INSTALL}/usr/share/doc/retroarch-joypad-autoconfig"
}
