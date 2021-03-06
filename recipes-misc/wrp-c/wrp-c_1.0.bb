SUMMARY = "C library for Web Routing Protocol (WRP)"
HOMEPAGE = "https://github.com/Comcast/wrp-c"
SECTION = "libs"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"

DEPENDS = "trower-base64 msgpack-c cimplog"

SRCREV = "adb7f0c152b930899caa08684d266d314a49b512"
SRC_URI = "git://github.com/Comcast/wrp-c.git"

SRC_URI += "file://0001-cleanup-__wrp_XXX_to_string-functions.patch"

PV = "git+${SRCPV}"

S = "${WORKDIR}/git"

ASNEEDED = ""

inherit pkgconfig cmake

EXTRA_OECMAKE = "-DBUILD_TESTING=OFF -DBUILD_YOCTO=true"

LDFLAGS += "-lcimplog -lmsgpackc -ltrower-base64"

# The libwrp-c.so shared lib isn't versioned, so force the .so file into the
# run-time package (and keep it out of the -dev package).

FILES_SOLIBSDEV = ""
FILES_${PN} += "${libdir}/*.so"

ASNEEDED_hybrid = ""
ASNEEDED_client = ""
