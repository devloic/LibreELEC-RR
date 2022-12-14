# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-2021 Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="libssh2-system"
PKG_VERSION="1.10.0"
PKG_SHA256="2d64e90f3ded394b91d3a2e774ca203a4179f69aebee03003e5a6fa621e41d51"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://www.libssh2.org"
PKG_URL="https://www.libssh2.org/download/libssh2-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl"
PKG_LONGDESC="A library implementing the SSH2 protocol"
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DBUILD_EXAMPLES=OFF \
                       -DBUILD_SHARED_LIBS=ON \
                       -DBUILD_TESTING=OFF"
