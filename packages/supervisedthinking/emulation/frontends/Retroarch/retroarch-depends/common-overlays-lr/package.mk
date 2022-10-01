# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="common-overlays-lr"
PKG_VERSION="e2ba730083769b45bac62d164115e7dc197c8b63"
PKG_SHA256="e8b09b7c87242c0687a50bb5eab165003a8fc11e4cd3e5fdf83245d92e9c7f91"
PKG_LICENSE="CC-BY-4.0 License"
PKG_SITE="https://github.com/libretro/common-overlays"
PKG_URL="https://github.com/libretro/common-overlays/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET=""
PKG_LONGDESC="Collection of overlay files for use with libretro frontends, such as RetroArch."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/retroarch/overlay
  cp -r ${PKG_BUILD}/borders ${INSTALL}/usr/share/retroarch/overlay
}
