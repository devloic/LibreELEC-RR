# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="openal-soft-system"
PKG_VERSION="$(get_pkg_version openal-soft)"
PKG_SHA256="3e58f3d4458f5ee850039b1a6b4dac2343b3a5985a6a2e7ae2d143369c5b8135"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="http://www.openal.org/"
PKG_URL="https://github.com/kcat/openal-soft/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib pulseaudio"
PKG_LONGDESC="OpenAL Soft is a software implementation of the OpenAL 3D audio API."

PKG_CMAKE_OPTS_TARGET="-DALSOFT_BACKEND_OSS=off \
                       -DALSOFT_BACKEND_PORTAUDIO=off \
                       -DALSOFT_BACKEND_WAVE=off \
                       -DALSOFT_EXAMPLES=off \
                       -DALSOFT_UTILS=off"

post_makeinstall_target() {
  mkdir -p ${INSTALL}/etc/openal
   sed s/^#drivers.*/drivers=alsa/ ${INSTALL}/usr/share/openal/alsoftrc.sample > ${INSTALL}/etc/openal/alsoft.conf
   safe_remove ${INSTALL}/usr/share/openal
}
