# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="pixel-es-theme"
PKG_VERSION="5d12229eb587af05d546ed963cabc9ddb5ab926b"
PKG_SHA256="9fd801f4a85c140f5a85647fea6ac84bbe74b3504a2bd8b7dac6a094ac61fca2"
PKG_LICENSE="OSS"
PKG_SITE="https://github.com/SupervisedThinking/es-theme-pixel"
PKG_URL="https://github.com/SupervisedThinking/es-theme-pixel/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Emulationstation theme 'pixel' v2.1-dev"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-sysroot"

PKG_MAKE_OPTS_TARGET="install DESTDIR=${INSTALL}"

post_makeinstall_target() {
  # Install stock theme
  ES_THEME_PATH=/usr/share/emulationstation/themes/pixel
  ES_CONFIG_PATH=/usr/config/emulationstation/themes
  mkdir -p ${INSTALL}/${ES_CONFIG_PATH}
    ln -s ${ES_THEME_PATH} ${INSTALL}/${ES_CONFIG_PATH}
}
