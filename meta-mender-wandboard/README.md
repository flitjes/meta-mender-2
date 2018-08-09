This meta layer is build for adding mender support to the wandboard with minimal changes to both freescale and mender provided meta layers.

This layer is dependend on:

meta
meta-poky
meta-yocto-bsp
meta-openembedded/meta-python
meta-openembedded/meta-oe
meta-openembedded/meta-networking
meta-freescale
meta-freescale-3rdparty
meta-freescale-distro
meta-mender/meta-mender-core
meta-mender/meta-mender-demo

Add the following to your local.conf

MACHINE ??= "wandboard-imx6-mender"
MENDER_ARTIFACT_NAME = "release-1"
INHERIT += "mender-full"
