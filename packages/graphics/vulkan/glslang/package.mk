# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="glslang"
# The SPIRV-Tools & SPIRV-Headers pkg_version/s need to match the compatible (known_good) glslang pkg_version.
# https://raw.githubusercontent.com/KhronosGroup/glslang/${PKG_VERSION}/known_good.json
# When updating glslang pkg_version please update to the known_good spirv-tools & spirv-headers pkg_version/s.
PKG_VERSION="11.13.0"
PKG_SHA256="592c98aeb03b3e81597ddaf83633c4e63068d14b18a766fd11033bad73127162"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/KhronosGroup/glslang"
PKG_URL="https://github.com/KhronosGroup/glslang/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host Python3:host spirv-tools:host spirv-headers:host"
PKG_DEPENDS_TARGET="toolchain Python3 spirv-tools spirv-headers"
PKG_LONGDESC="Khronos-reference front end for GLSL/ESSL, partial front end for HLSL, and a SPIR-V generator."

pre_configure_host() {
  PKG_CMAKE_OPTS_HOST="-DBUILD_SHARED_LIBS=OFF \
                       -DBUILD_EXTERNAL=ON \
                       -DENABLE_SPVREMAPPER=OFF \
                       -DENABLE_GLSLANG_JS=OFF \
                       -DENABLE_RTTI=OFF \
                       -DENABLE_EXCEPTIONS=OFF \
                       -DENABLE_OPT=ON \
                       -DENABLE_PCH=ON \
                       -DENABLE_CTEST=OFF \
                       -DENABLE_RTTI=OFF \
                       -Wno-dev"

  mkdir -p ${PKG_BUILD}/External/spirv-tools/external/spirv-headers
    cp -R $(get_build_dir spirv-tools)/* ${PKG_BUILD}/External/spirv-tools
    cp -R $(get_build_dir spirv-headers)/* ${PKG_BUILD}/External/spirv-tools/external/spirv-headers
}

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=ON \
                         -DBUILD_EXTERNAL=ON \
                         -DENABLE_SPVREMAPPER=OFF \
                         -DENABLE_GLSLANG_BINARIES=OFF \
                         -DENABLE_GLSLANG_JS=OFF \
                         -DENABLE_RTTI=OFF \
                         -DENABLE_EXCEPTIONS=OFF \
                         -DENABLE_OPT=ON \
                         -DENABLE_PCH=ON \
                         -DENABLE_CTEST=OFF \
                         -DENABLE_RTTI=OFF \
                         -Wno-dev"

  mkdir -p ${PKG_BUILD}/External/spirv-tools/external/spirv-headers
    cp -R $(get_build_dir spirv-tools)/* ${PKG_BUILD}/External/spirv-tools
    cp -R $(get_build_dir spirv-headers)/* ${PKG_BUILD}/External/spirv-tools/external/spirv-headers
}

post_makeinstall_target() {
  # Fix INTERFACE_INCLUDE_DIRECTORIES of glslang::SPIRV 
  sed -e "s#/External##g" -i ${SYSROOT_PREFIX}/usr/share/glslang/glslang-targets.cmake
}
