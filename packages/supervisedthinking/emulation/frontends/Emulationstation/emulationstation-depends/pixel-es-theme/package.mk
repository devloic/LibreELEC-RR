# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="pixel-es-theme"
PKG_VERSION="c00c9451be00d3a1c19fb51ca55c240ffda462d2"
PKG_SHA256="7231e243a3c4346c006890b536a99ce4731bbba3be153a9e4ed8c5b1fe27fcd0"
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
