# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="espeak-ng"
PKG_VERSION="1.50"
PKG_SHA256="80ee6cd06fcd61888951ab49362b400e80dd1fac352a8b1131d90cfe8a210edb"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/espeak-ng/espeak-ng"
PKG_URL="https://github.com/espeak-ng/espeak-ng/releases/download/${PKG_VERSION}/espeak-ng-${PKG_VERSION}.tgz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="eSpeak NG is an open source speech synthesizer that supports more than a hundred languages and accents"
PKG_TOOLCHAIN="autotools"

post_unpack() {
  safe_remove ${PKG_BUILD}/m4/{libtool.m4,lt~obsolete.m4,ltoptions.m4,ltsugar.m4,ltversion.m4}
}

pre_configure() {
  cd ${PKG_BUILD}
  ./autogen.sh
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
