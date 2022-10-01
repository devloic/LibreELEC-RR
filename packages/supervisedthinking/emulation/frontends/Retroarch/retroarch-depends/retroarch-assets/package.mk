# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="retroarch-assets"
PKG_VERSION="ee33f8ef693b42a8e23ca3fd48f43f345e7cd087"
PKG_SHA256="b110163b0898b56be5245fd77a626b69fe5624234a5bf6af22487e2c2ee50a33"
PKG_LICENSE="CC-BY-4.0"
PKG_SITE="https://github.com/libretro/retroarch-assets"
PKG_URL="https://github.com/libretro/retroarch-assets/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="gcc:host"
PKG_LONGDESC="RetroArch assets. Background and icon themes for the menu drivers."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}
  make install INSTALLDIR="${INSTALL}/usr/share/retroarch/assets"
}

post_makeinstall_target() {
  # Remove unnecessary files
  safe_remove ${INSTALL}/usr/share/retroarch/assets/Automatic
  safe_remove ${INSTALL}/usr/share/retroarch/assets/branding
  safe_remove ${INSTALL}/usr/share/retroarch/assets/cfg
  safe_remove ${INSTALL}/usr/share/retroarch/assets/ctr
  safe_remove ${INSTALL}/usr/share/retroarch/assets/devtools
  safe_remove ${INSTALL}/usr/share/retroarch/assets/FlatUX
  safe_remove ${INSTALL}/usr/share/retroarch/assets/fonts
  safe_remove ${INSTALL}/usr/share/retroarch/assets/nxrgui
  safe_remove ${INSTALL}/usr/share/retroarch/assets/README.md
  safe_remove ${INSTALL}/usr/share/retroarch/assets/scripts
  safe_remove ${INSTALL}/usr/share/retroarch/assets/Systematic
  safe_remove ${INSTALL}/usr/share/retroarch/assets/wallpapers
}
