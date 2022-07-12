# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="xpadneo"
PKG_VERSION="0.9.4"
PKG_SHA256="6682feaf0ba730b08d36f6d0fb091ca480bbbebf0d4ea796abf78e872b15096f"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://atar-axis.github.io/xpadneo/"
PKG_URL="https://github.com/atar-axis/xpadneo/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux bluez"
PKG_NEED_UNPACK="${LINUX_DEPENDS}"
PKG_LONGDESC="Advanced Linux Driver for Xbox One Wireless Controller (shipped with Xbox One S)"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="make"

make_target() {
  kernel_make -C $(kernel_path) M=${PKG_BUILD}/hid-xpadneo/src modules
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/kernel/drivers/hid
   cp -rv ${PKG_BUILD}/hid-xpadneo/src/*.ko ${INSTALL}/$(get_full_module_dir)/kernel/drivers/hid

  # Install modprobe.d config files
  cp -PRv ${PKG_DIR}/config/* ${INSTALL}
}
