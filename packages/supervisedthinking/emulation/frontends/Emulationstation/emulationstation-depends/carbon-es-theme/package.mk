# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="carbon-es-theme"
PKG_VERSION="309c902ae3513cb8889c0173ee261ea42c731092"
PKG_SHA256="6b02653a15a4bd5e06986528f9d0892e1cca1cd2d11c9912b72cf844a5bc6327"
PKG_LICENSE="CC-BY-NC-SA-2.0"
PKG_SITE="https://github.com/SupervisedThinking/es-theme-carbon/"
PKG_URL="https://github.com/SupervisedThinking/es-theme-carbon//archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Theme 'carbon' v2.4 - 08-16-2016 by Rookervik"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-sysroot"

PKG_MAKE_OPTS_TARGET="install DESTDIR=${INSTALL}"

post_makeinstall_target() {
  # Install stock theme
  ES_THEME_PATH=/usr/share/emulationstation/themes/carbon
  ES_CONFIG_PATH=/usr/config/emulationstation/themes
  mkdir -p ${INSTALL}/${ES_CONFIG_PATH}
    ln -s ${ES_THEME_PATH} ${INSTALL}/${ES_CONFIG_PATH}
}
