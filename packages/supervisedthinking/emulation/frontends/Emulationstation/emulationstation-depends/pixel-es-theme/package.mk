# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="pixel-es-theme"
PKG_VERSION="ab632ef9ef42c9d7de93ad33bb14d1fffc608106"
PKG_SHA256="935cca97d771d6b4ff247572b26171678bde2dc71679f84735e5c318bc850164"
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
