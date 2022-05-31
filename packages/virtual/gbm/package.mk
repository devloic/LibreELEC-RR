# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gbm"
PKG_VERSION=""
PKG_LICENSE="OSS"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="virtual"
PKG_LONGDESC="Generic Buffer Management (GBM)"

# NVIDIA drivers for Linux
if listcontains "${GRAPHIC_DRIVERS}" "nvidia-ng"; then
  PKG_DEPENDS_TARGET+=" nvidia"
fi
