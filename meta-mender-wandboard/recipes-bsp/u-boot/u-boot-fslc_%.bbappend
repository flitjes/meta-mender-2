FILESEXTRAPATHS_prepend := "${THISDIR}/patches:"

SRC_URI_append := " file://0099-Wandboard-Bootargs.patch"

require recipes-bsp/u-boot/u-boot-mender.inc

MENDER_BOOTLOADER_BLOB ?= "SPL_UBOOT"
MENDER_BOOTLOADER_BLOB_BOOTLOADER ?= "u-boot.img"
MENDER_BOOTLOADER_BLOB_SPL ?= "${SPL_BINARY}"


do_install_append(){
	#Mender is able to add a bootloader to the sdimage
	#The wanboard requires the SPL and bootloader to boot
	#To prevent changes to mender, these two are concatinated so they can be included
	#by the do_image_sd task
	#Results in:
	# |     SPL     |    U-boot   |
	# | 0x0000 0000 | 0x0001 1000 |
	#Blob shall be inserted with an offset of 0x400 by the do_image_sd_task
	#Resulting in 0x400 SPL 0x11400 U-Boot
	#|     MBR     |     SPL     |    U-boot   |  U-boot env  |    boot    |  primary   |  secondary |    data    | 
	#| 0x0000 0000 | 0x0000 0400 | 0x0001 1400 |  0x0800 0000 | TBD MENDER | TBD MENDER | TBD MENDER | TBD MENDER |
	#rm -f ${DEPLOY_DIR_IMAGE}/${MENDER_BOOTLOADER_BLOB}
	#cp ${DEPLOY_DIR_IMAGE}/${MENDER_BOOTLOADER_BLOB_SPL} ${DEPLOY_DIR_IMAGE}/${MENDER_BOOTLOADER_BLOB}
	#dd if=${DEPLOY_DIR_IMAGE}/${MENDER_BOOTLOADER_BLOB_BOOTLOADER} of=${DEPLOY_DIR_IMAGE}/${MENDER_BOOTLOADER_BLOB} bs=1k seek=68
	rm -f ${D}/boot/${MENDER_BOOTLOADER_BLOB}
	cp ${D}/boot/${MENDER_BOOTLOADER_BLOB_SPL} ${DEPLOY_DIR_IMAGE}/${MENDER_BOOTLOADER_BLOB}
	dd if=${D}/boot/${MENDER_BOOTLOADER_BLOB_BOOTLOADER} of=${DEPLOY_DIR_IMAGE}/${MENDER_BOOTLOADER_BLOB} bs=1k seek=68

}
