SUMMARY = "Generic version of CCSP Firewall HAL"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://../../LICENSE;md5=175792518e4ac015ab6696d16c4f607e"

DEPENDS = "halinterface ccsp-common-library"

PROVIDES = "hal-firewall"
RPROVIDES_${PN} = "hal-firewall"

PV = "${RDK_RELEASE}+git${SRCPV}"

SRC_URI = "${LGI_RDKB_GIT}/hal.git;protocol=${LGI_RDKB_GIT_PROTOCOL};branch=${LGI_RDKB_GIT_BRANCH};name=firewallhal"

SRCREV_firewallhal ?= "${AUTOREV}"
SRCREV_FORMAT = "firewallhal"

S = "${WORKDIR}/git/source/firewall"

inherit autotools

CFLAGS += "-I${STAGING_INCDIR}/ccsp"
