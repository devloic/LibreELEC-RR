# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="RPi"
PKG_VERSION="1.0.11"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://bit.ly/3vL5rH3"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Metapackage for various LibreELEC-RR OEM packages"
PKG_TOOLCHAIN="manual"

################################################################################
# Setup packages included in Raspberry Pie images
################################################################################

# Applications
OEM_APPLICATIONS_RPI=""

# Libretro cores
OEM_EMULATORS_LIBRETRO_RPI=" \
  retroarch \
  2048 \
  a5200 \
  atari800 \
  beetle-lynx \
  beetle-pce-fast \
  beetle-pcfx \
  beetle-wswan \
  bluemsx \
  chailove \
  desmume \
  dosbox-pure \
  ecwolf \
  fbneo \
  flycast \
  fuse-libretro \
  gambatte \
  genesis-plus-gx \
  genesis-plus-gx-wide \
  jumpnbump \
  mame2003-plus \
  mame2010 \
  mgba \
  mrboom \
  mupen64plus-nx \
  nestopia \
  opera \
  pcsx_rearmed \
  picodrive \
  prboom \
  prosystem \
  sameboy \
  scummvm \
  snes9x \
  snes9x2010 \
  stella2014 \
  superbroswar \
  tyrquake \
  vice-libretro \
  virtualjaguar \
  yabause"

# Libretro cores for RPi4
OEM_EMULATORS_LIBRETRO_RPI_RPI4=" \
  bsnes-libretro \
  mame2016 \
  mesen-x \
  puae \
  yabasanshiro"

# Standalone emulators
OEM_EMULATORS_STANDALONE_RPI=" \
  emulationstation \
  amiberry \
  dosbox-staging \
  hatari \
  openbor \
  ppsspp"

# Extra frontends
OEM_FRONTENDS_EXTRA_RPI=" \
  pegasus-frontend"

# Linux drivers
OEM_LINUX_KERNEL_DRIVERS_RPI=" \
  xpadneo"

# Non free packages
OEM_NON_FREE_PACKAGES_RPI=" \
  xow"

# Streaming clients
OEM_STREAMING_CLIENTS_RPI=" \
  moonlight-qt" 

# Tools
OEM_TOOLS_RPI=" \
  dhrystone-benchmark \
  ds4drv \
  evtest \
  glmark2 \
  htop-system \
  lm-sensors \
  midnight-commander \
  rr-config-tool \
  sdl-jstest \
  skyscraper"

################################################################################
# Install OEM packages to LibreELEC-RR
################################################################################

configure_package() {
  if [ "${OEM_SUPPORT}" = "yes" ]; then

    # Add application packages
    if [ "${OEM_APPLICATIONS}" = "yes" ]; then
      PKG_DEPENDS_TARGET+=" ${OEM_APPLICATIONS_RPI}"
    fi

    # Add Emulationstation frontend & standalone emulator packages
    if [ "${OEM_EMULATORS}" = "yes" ]; then
      PKG_DEPENDS_TARGET+=" ${OEM_EMULATORS_STANDALONE_RPI}"
    fi

    # Add additional frontend packages
    if [ "${OEM_FRONTENDS_EXTRA}" = "yes" ]; then
      PKG_DEPENDS_TARGET+=" ${OEM_FRONTENDS_EXTRA_RPI}"
    fi

    # Add Retroarch frontend & libretro core packages 
    if [ "${OEM_LIBRETRO}" = "yes" ]; then
      PKG_DEPENDS_TARGET+=" ${OEM_EMULATORS_LIBRETRO_RPI}"
      # Add device specific libretro core packages 
      if [ "${DEVICE}" = "RPi4" ]; then
        PKG_DEPENDS_TARGET+=" ${OEM_EMULATORS_LIBRETRO_RPI_RPI4}"
      fi
    fi

    # Add Linux driver packages
    if [ "${OEM_LINUX_KERNEL_DRIVER_SUPPORT}" = "yes" ]; then
      PKG_DEPENDS_TARGET+=" ${OEM_LINUX_KERNEL_DRIVERS_RPI}"
    fi

    # Add non free packages
    if [ "${NON_FREE_PKG_SUPPORT}" = "yes" ]; then
      PKG_DEPENDS_TARGET+=" ${OEM_NON_FREE_PACKAGES_RPI}"
    fi

    # Add streaming packages
    if [ "${OEM_STREAMING_CLIENTS}" = "yes" ]; then
      PKG_DEPENDS_TARGET+=" ${OEM_STREAMING_CLIENTS_RPI}"
    fi

    # Add tool packages
    if [ "${OEM_TOOLS}" = "yes" ]; then
      PKG_DEPENDS_TARGET+=" ${OEM_TOOLS_RPI}"
    fi
  fi
}

makeinstall_target() {
  # Create directories
  mkdir -p ${INSTALL}

  # Install OEM config files & scripts
  cp -PRv ${PKG_DIR}/config/* ${INSTALL}
}
