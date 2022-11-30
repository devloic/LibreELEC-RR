# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xwayland"
PKG_VERSION="22.1.5"
PKG_SHA256="beee7d0ec21f1c7675c1cd327fb8654412203f06a036506bb1aaebcce2c35879"
PKG_LICENSE="OSS"
PKG_SITE="https://wayland.freedesktop.org/xserver.html"
PKG_URL="https://github.com/freedesktop/xorg-xserver/archive/refs/tags/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain systemd libdrm pixman openssl wayland wayland-protocols xorgproto xtrans xkbcomp libxkbfile libXfont2 libxcvt libxshmfence "
PKG_LONGDESC="The Xwayland package is an Xorg server running on top of the wayland server. It has been separated from the main Xorg server package. It allows running X clients inside a wayland session."
PKG_BUILD_FLAGS="-sysroot"

PKG_MESON_OPTS_TARGET="-Dxwayland_eglstream=false \
                       -Dxvfb=false \
                       -Dbuilder_addr="https://github.com/LibreELEC/LibreELEC.tv" \
                       -Dbuilder_string=${BUILDER_NAME} \
                       -Ddefault_font_path="/usr/share/fonts/misc,built-ins" \
                       -Dxdmcp=false \
                       -Dxdm-auth-1=false \
                       -Dsecure-rpc=false \
                       -Dipv6=false \
                       -Dinput_thread=true \
                       -Dxkb_dir=${XORG_PATH_XKB} \
                       -Dxkb_output_dir="/var/cache/xkb" \
                       -Dvendor_name="LibreELEC" \
                       -Dvendor_name_short="LE" \
                       -Dvendor_web="https://libreelec.tv/" \
                       -Ddtrace=false \
                       -Dlisten_tcp=false \
                       -Dlisten_unix=true \
                       -Dlisten_local=false \
                       -Ddpms=true \
                       -Dxf86bigfont=false \
                       -Dscreensaver=false \
                       -Dxres=true \
                       -Dxace=false \
                       -Dxselinux=false \
                       -Dxinerama=true \
                       -Dxcsecurity=false \
                       -Dxv=true \
                       -Dmitshm=true \
                       -Dsha1="libcrypto" \
                       -Ddri3=true \
                       -Ddrm=true \
                       -Dlibunwind=false \
                       -Ddocs=false \
                       -Ddevel-docs=false \
                       -Ddocs-pdf=false"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} libepoxy"
  PKG_MESON_OPTS_TARGET+=" -Dglx=true \
                           -Dglamor=true"
else
  PKG_MESON_OPTS_TARGET+=" -Dglx=false \
                           -Dglamor=false"
fi

makeinstall_target() {
 :
}
