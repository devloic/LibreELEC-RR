# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="libxshmfence-system"
PKG_VERSION="$(get_pkg_version libxshmfence)"
PKG_SHA256="1129f95147f7bfe6052988a087f1b7cb7122283d2c47a7dbf7135ce0df69b4f8"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/lib/${PKG_NAME:0:12}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-macros xorgproto"
PKG_LONGDESC="libxshmfence is the Shared memory 'SyncFence' synchronization primitive."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic -sysroot"
