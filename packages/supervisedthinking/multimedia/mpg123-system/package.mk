# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="mpg123-system"
PKG_VERSION="$(get_pkg_version mpg123)"
PKG_SHA256="c7ea863756bb79daed7cba2942ad3b267a410f26d2dfbd9aaf84451ff28a05d7"
PKG_LICENSE="LGPL-2.0-or-later"
PKG_SITE="http://www.mpg123.org/"
PKG_URL="http://downloads.sourceforge.net/sourceforge/mpg123/mpg123-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain alsa-lib"
PKG_LONGDESC="A console based real time MPEG Audio Player for Layer 1, 2 and 3."
