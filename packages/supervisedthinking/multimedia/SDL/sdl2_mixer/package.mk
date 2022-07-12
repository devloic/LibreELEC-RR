# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="sdl2_mixer"
PKG_VERSION="2.6.0"
PKG_SHA256="590dbcc8d738337344d77e8d837fbc648c52f3aff076ef2b007537f886a92809"
PKG_LICENSE="SDL"
PKG_SITE="https://libsdl.org/projects/SDL_mixer/"
PKG_URL="https://github.com/libsdl-org/SDL_mixer/archive/release-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain sdl2 flac-system fluidsynth-system libvorbis-system mpg123-system opusfile"
PKG_LONGDESC="An audio mixer that supports various file formats for Simple Directmedia Layer."
PKG_TOOLCHAIN="configure"
