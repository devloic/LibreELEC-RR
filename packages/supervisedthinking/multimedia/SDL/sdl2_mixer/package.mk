# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="sdl2_mixer"
PKG_VERSION="2.6.3"
PKG_SHA256="91dd065e9e63f499e5317350b110184b0ba96bc5f63c39b3a9939a136c40c035"
PKG_LICENSE="SDL"
PKG_SITE="https://libsdl.org/projects/SDL_mixer/"
PKG_URL="https://github.com/libsdl-org/SDL_mixer/archive/release-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain sdl2 flac-system fluidsynth-system libvorbis-system mpg123-system opusfile"
PKG_LONGDESC="An audio mixer that supports various file formats for Simple Directmedia Layer."
PKG_TOOLCHAIN="configure"
