#!/usr/bin/env bash
set -e

# Colors
RED="\033[0;31m"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

function panic() {
  printf "${RED}ERROR:${NC} %s\n" "$*" >&2
  exit 1
}

# Paths
PWD=$(pwd)
HUB_INSTALL_DIR="${HUB_INSTALL_DIR:-/opt/asic-hub}"
BIN_INSTALL_DIR=/usr/bin
HUB_CONFIG_DIR=/etc/asic-hub
HUB_DATA_DIR=/var/lib/asic-hub
HUB_LOG_DIR=/var/log/asic-hub
__FILE=$(basename "$0")


# Distribution files
HUB_BIN=hub
HUBCTL_BIN=hubctl
HUB_CFG=config.toml
HUB_WWW=public

# Destinations
HUBCTL_SYMLINK="$BIN_INSTALL_DIR/$HUBCTL_BIN"
HUBCTL_SRC="$HUB_INSTALL_DIR/$HUBCTL_BIN"

if [ ${EUID:-$(id -u)} -ne 0 ]; then
	panic "you cannot perform this operation unless you are root"
fi

echo ":: Creating directories..."
install -d "$HUB_INSTALL_DIR"
install -d "$HUB_CONFIG_DIR"
install -d "$HUB_LOG_DIR"
install -d "$HUB_DATA_DIR"

echo ":: Copying files..."
install -v -D $HUB_BIN "$HUB_INSTALL_DIR"
install -v -D $HUBCTL_BIN "$HUB_INSTALL_DIR"

[ ! -L $HUBCTL_SYMLINK ] && ln -v -s "$HUBCTL_SRC" $HUBCTL_SYMLINK
cp -rfv $HUB_WWW "$HUB_INSTALL_DIR/$HUB_WWW"
install -v -m 644 -D $HUB_CFG $HUB_CONFIG_DIR

# Increase max threads limit if CPU has less or equal 4 cores
# shellcheck disable=SC2046
[ $(nproc) -le 4 ] && sed -i 's/\#MaxThreads=[0-9]/MaxThreads=8/g' "$HUB_CONFIG_DIR/$HUB_CFG"

# shellcheck disable=SC2059
printf "\n${GREEN}[✓]${NC} Installation finished. Open http://localhost:8800 to configure ASIC Hub.\n"
