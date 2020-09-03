SUMMARY = "Generic version of CCSP Ethernet Switch HAL"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://../../LICENSE;md5=175792518e4ac015ab6696d16c4f607e"

DEPENDS = "halinterface"

PROVIDES = "hal-ethsw"
RPROVIDES_${PN} = "hal-ethsw"

PV = "${RDK_RELEASE}+git${SRCPV}"

SRC_URI = "${LGI_RDKB_GIT}/hal.git;protocol=${LGI_RDKB_GIT_PROTOCOL};branch=${LGI_RDKB_GIT_BRANCH};name=ethswhal"

SRCREV_ethswhal ?= "${AUTOREV}"
SRCREV_FORMAT = "ethswhal"

S = "${WORKDIR}/git/source/ethsw"

inherit autotools

CFLAGS += "-I${STAGING_INCDIR}/ccsp"
