# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="sdl_gamecontrollerdb"
PKG_VERSION="cf0cfc714f91b61153671226a9562e748fafea1d"
PKG_SHA256="98484b177713ec3a9125408063cb4c0b243e3fccac42afb791ea15660534389e"
PKG_LICENSE="SDL"
PKG_SITE="https://github.com/gabomdq/SDL_GameControllerDB"
PKG_URL="https://github.com/gabomdq/SDL_GameControllerDB/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET=""
PKG_LONGDESC="A community sourced database of game controller mappings to be used with SDL2 Game Controller functionality"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  # Paths
  PKG_CONFIG_PATH="/usr/config/SDL-GameControllerDB"
  PKG_SHARE_PATH="/usr/share/sdl-gamecontrollerdb"
  PKG_DATABASE_PATH="${PKG_BUILD}/gamecontrollerdb.txt"

  # Clean up database
  sed -e "/Windows/d" -i ${PKG_DATABASE_PATH}
  sed -e "/Mac/d"     -i ${PKG_DATABASE_PATH}
  sed -e "/Android/d" -i ${PKG_DATABASE_PATH}
  sed -e "/iOS/d"     -i ${PKG_DATABASE_PATH}
  sed -e "/^$/d"      -i ${PKG_DATABASE_PATH}

  # Install files
  mkdir -p ${INSTALL}/${PKG_CONFIG_PATH}
  mkdir -p ${INSTALL}/${PKG_SHARE_PATH}
   cp -v ${PKG_DATABASE_PATH} ${INSTALL}/${PKG_SHARE_PATH}
   ln -sf ${PKG_SHARE_PATH}/gamecontrollerdb.txt ${INSTALL}/${PKG_CONFIG_PATH}/gamecontrollerdb.txt
}
