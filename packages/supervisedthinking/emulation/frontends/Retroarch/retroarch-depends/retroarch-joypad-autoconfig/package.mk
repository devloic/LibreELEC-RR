# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="retroarch-joypad-autoconfig"
PKG_VERSION="1.13.0"
PKG_SHA256="5a77762d2c6ab873c0193a41eaaaf26624be94dc04ade0955bd9ac5afa29b133"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/retroarch-joypad-autoconfig"
PKG_URL="https://github.com/libretro/retroarch-joypad-autoconfig/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="gcc:host"
PKG_LONGDESC="RetroArch joypad autoconfig files"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/share/retroarch/autoconfig" DOC_DIR="${INSTALL}/usr/share/doc/retroarch-joypad-autoconfig"
}
