# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="gst-plugins-good"
PKG_VERSION="1.20.3"
PKG_SHA256="f8f3c206bf5cdabc00953920b47b3575af0ef15e9f871c0b6966f6d0aa5868b7"
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
  if [ "${DEVICE}" = "RPi4" -o "${DEVICE}" = "RPi3" ]; then
    PKG_MESON_OPTS_TARGET+=" -Drpicamsrc=disabled"
  fi

post_makeinstall_target(){
  # Clean up
  safe_remove ${INSTALL}/usr/share
}
