FILESEXTRAPATHS_prepend := "${THISDIR}/patches:"

SRC_URI_append := " file://0099-Wandboard-Bootargs.patch"

require recipes-bsp/u-boot/u-boot-mender.inc
