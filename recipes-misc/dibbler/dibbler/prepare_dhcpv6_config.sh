#!/bin/sh
##########################################################################
# If not stated otherwise in this file or this component's Licenses.txt
# file the following copyright and licenses apply:
#
# Copyright 2015 RDK Management
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################################################################

if [ -f /etc/device.properties ];then
     . /etc/device.properties
fi
# Fixme: hardcoding is a temporary solution. They should be taken from device.properties
#BOX_TYPE="MV1"
#ARM_INTERFACE="erouter0"

VENDOR_SPEC_FILE="/etc/dibbler/udhcpc.vendor_specific"
OPTION_FILE="/tmp/vendor_spec.txt"
DHCP_CONFIG_FILE="/etc/dibbler/client.conf"
DHCP_CONFIG_FILE_RFS="/etc/dibbler/client.conf-basic"
DHCP_CONFIG_FILE_TMP="/tmp/dibbler/client.conf"
#interface=$ARM_INTERFACE

ethWanMode=`syscfg get eth_wan_enabled`
DSLite_Enabled=`syscfg get dslite_enable`
#interface is $ARM_INTERFACE which comes from device.properties
#interface=erouter0 is now specified in client.conf-basic
#if [ "$interface" ] && [ -f /etc/dibbler/client_back.conf ];then
#    sed -i "s/RDK-ESTB-IF/${interface}/g" /etc/dibbler/client_back.conf
#fi


if [ -f $OPTION_FILE ]; then
        rm -rf $OPTION_FILE
fi

updateOptInfo()
{
  opt_val=$1
  subopt_num=$2
  subopt_len=`echo ${#opt_val}`
  subopt_len_h=`printf "%04x\n" $subopt_len`;
  subopt_val_h=`echo -n $opt_val | hexdump -e '13/1 "%02x"'`
  echo -n $subopt_num$subopt_len_h$subopt_val_h >> $OPTION_FILE
  return
}

if [ "$DSLite_Enabled" = "1" ];then
	echo  "        option aftr" >> $OPTION_FILE
fi

if [ "$EROUTER_DHCP_OPTION_EMTA_ENABLED" = "true" ] &&  [ "$ethWanMode" = "true" ];then 
        echo -n "        option 0017 hex 0x0000118b000100060027087A087B" >> $OPTION_FILE
else
        echo -n "        option 0017 hex 0x0000118b" >> $OPTION_FILE
fi
    while read line
    do
        mode=`echo $line | cut -f1 -d" "`
        opt_num=`echo $line | cut -f2 -d" "`
        opt_val=`echo $line | cut -f3 -d" "`
        case "$opt_num" in
            "SUBOPTION2")
                subopt_num="0002"
                updateOptInfo $opt_val $subopt_num
                ;;
            "SUBOPTION3")
                subopt_num="0003"
                if [ "$EROUTER_DHCP_OPTION_EMTA_ENABLED" = "true" ]  ;then 
                        if [ "$mode" = "DOCSIS" ] && [ "$ethWanMode" = "true" ] ;then
                                continue;
                        fi

                        if [ "$mode" = "ETHWAN" ] && [ "$ethWanMode" = "false" ] ;then
                                continue;
                        fi
                elif [ "$mode" = "ETHWAN" ] ;then
                        continue;
                fi
                updateOptInfo $opt_val $subopt_num
                ;;
        esac;
    done < "$VENDOR_SPEC_FILE"

if [ "$EROUTER_DHCP_OPTION_EMTA_ENABLED" = "true" ] && [ "$ethWanMode" = "true" ];then 
    echo -n "0027000107" >> $OPTION_FILE
fi
 

if [ -f "$DHCP_CONFIG_FILE_TMP" ]; then
    rm -rf $DHCP_CONFIG_FILE_TMP
fi

sed '$d' $DHCP_CONFIG_FILE_RFS > $DHCP_CONFIG_FILE_TMP
cat $OPTION_FILE >> $DHCP_CONFIG_FILE_TMP
echo >> $DHCP_CONFIG_FILE_TMP
echo "}" >> $DHCP_CONFIG_FILE_TMP

#get rid of the bad prefix stuffs
