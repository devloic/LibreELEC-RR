# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="gst-plugins-good"
PKG_VERSION="$(get_pkg_version gstreamer)"
PKG_SHA256="582e617271e7f314d1a2211e3e3856ae2e4303c8c0d6114e9c4a5ea5719294b0"
PKG_LICENSE="LGPL-2.1-or-later"
PKG_SITE="https://gstreamer.freedesktop.org/modules/gst-plugins-good.html"
PKG_URL="https://gstreamer.freedesktop.org/src/gst-plugins-good/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain gstreamer gst-plugins-base"
PKG_LONGDESC="Good GStreamer plugins and helper libraries"

PKG_MESON_OPTS_TARGET="-Dgdk-pixbuf=disabled \
                       -Dqt5=disabled \
                       -Dtaglib=disabled \
                       -Dexamples=disabled \
                       -Dtests=disabled \
                       -Dnls=disabled"

  # Fix missing dispmanx
  if [ "${DEVICE}" = "RPi4" -o "${DEVICE}" = "RPi2" ]; then
    PKG_MESON_OPTS_TARGET+=" -Drpicamsrc=disabled"
  fi

post_makeinstall_target(){
  # Clean up
  safe_remove ${INSTALL}/usr/share
}
