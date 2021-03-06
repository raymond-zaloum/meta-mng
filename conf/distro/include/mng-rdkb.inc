
# ----------------------------------------------------------------------

# Enable the _broadband over-ride (for compatibility with external meta layers
# only - no local recipes should be relying on it). Note that upstream RDKB
# enables the over-ride via MACHINEOVERRIDES in each individual machine config.
# Enabling globally via DISTROOVERRIDES is a little cleaner.

DISTROOVERRIDES .= ":broadband"

# ----------------------------------------------------------------------

DISTRO_FEATURES_append = " dslite"
DISTRO_FEATURES_append = " fcgi"
DISTRO_FEATURES_append = " meshwifi"
DISTRO_FEATURES_append = " snmppa"
DISTRO_FEATURES_append = " webui2"

# ----------------------------------------------------------------------

CCSP_CONFIG_ARCH ?= ""
CCSP_CONFIG_PLATFORM ?= ""

CCSP_CFLAGS_MACHINE ?= ""

# ----------------------------------------------------------------------

PREFERRED_PROVIDER_hal-cm ?= "hal-cm-generic"
PREFERRED_PROVIDER_hal-dhcpv4c ?= "hal-dhcpv4c-generic"
PREFERRED_PROVIDER_hal-epon ?= "hal-epon-generic"
PREFERRED_PROVIDER_hal-ethsw ?= "hal-ethsw-generic"
PREFERRED_PROVIDER_hal-firewall ?= "hal-firewall-generic"
PREFERRED_PROVIDER_hal-moca ?= "hal-moca-generic"
PREFERRED_PROVIDER_hal-mso_mgmt ?= "hal-mso-mgmt-generic"
PREFERRED_PROVIDER_hal-mta ?= "hal-mta-generic"
PREFERRED_PROVIDER_hal-platform ?= "hal-platform-generic"
PREFERRED_PROVIDER_hal-vlan ?= "hal-vlan-generic"
PREFERRED_PROVIDER_hal-wifi ?= "hal-wifi-generic"

# ----------------------------------------------------------------------
