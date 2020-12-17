SUMMARY = "Generic version of CCSP MSO Management HAL"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://../../LICENSE;md5=175792518e4ac015ab6696d16c4f607e"

DEPENDS = "halinterface"

PROVIDES = "hal-mso_mgmt"
RPROVIDES_${PN} = "hal-mso_mgmt"

PV = "${RDK_RELEASE}+git${SRCPV}"

SRC_URI = "${LGI_RDKB_GIT}/hal.git;protocol=${LGI_RDKB_GIT_PROTOCOL};branch=${LGI_RDKB_GIT_BRANCH}"

SRCREV ?= "${AUTOREV}"

S = "${WORKDIR}/git/source/mso_mgmt"

inherit autotools

CFLAGS += "-I${STAGING_INCDIR}/ccsp"
