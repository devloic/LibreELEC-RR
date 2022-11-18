# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="htop-system"
PKG_VERSION="$(get_pkg_version htop)"
PKG_SHA256="b5ffac1949a8daaabcffa659c0964360b5008782aae4dfa7702d2323cfb4f438"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://hisham.hm/htop"
PKG_URL="https://github.com/htop-dev/htop/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_LONGDESC="htop is a cross-platform interactive process viewer."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET="--disable-unicode \
                           HTOP_NCURSES_CONFIG_SCRIPT=ncurses-config"

post_makeinstall_target() {
  # clean up
  safe_remove ${INSTALL}/usr/share
}
