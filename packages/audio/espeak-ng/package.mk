# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="espeak-ng"
PKG_VERSION="1.50"
PKG_SHA256="5ce9f24ee662b5822a4acc45bed31425e70d7c50707b96b6c1603a335c7759fa"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/espeak-ng/espeak-ng"
PKG_URL="https://github.com/espeak-ng/espeak-ng/archive/refs/tags/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain espeak-ng:host"
PKG_LONGDESC="eSpeak NG is an open source speech synthesizer that supports more than a hundred languages and accents"
PKG_TOOLCHAIN="autotools"

pre_configure_host() {
  cd ${PKG_BUILD}
  ./autogen.sh
}

pre_configure_target() {
  cd ${PKG_BUILD}
  make clean
  ./autogen.sh
}

make_host() {
  make src/espeak-ng src/speak-ng
  make -j1
}

makeinstall_host() {
 :
}

make_target() {
  make src/espeak-ng src/speak-ng
}

makeinstall_target() {
  make install-exec DESTDIR=${INSTALL}
  make install-data DESTDIR=${INSTALL}
}

post_makeinstall_target() {
  safe_remove ${INSTALL}/usr/share/vim
}
