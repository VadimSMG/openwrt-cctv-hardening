#!/bin/sh
# Hardening firewall rules
HIK1IP="1.2.3.21"
HIK2IP="1.2.3.22"

echo "Applying Hardening Rules..."

# Block Hikvision 1
rule1=$(uci add firewall rule)
uci set firewall.$rule1.name='Block_Hik_1_Internet'
uci set firewall.$rule1.src='lan'
uci set firewall.$rule1.dest='wan'
uci set firewall.$rule1.src_ip="$HIK1IP"
uci set firewall.$rule1.target='REJECT'

# Block Hikvision 2
rule2=$(uci add firewall rule)
uci set firewall.$rule2.name='Block_Hik_2_Internet'
uci set firewall.$rule2.src='lan'
uci set firewall.$rule2.dest='wan'
uci set firewall.$rule2.src_ip="$HIK2IP"
uci set firewall.$rule2.target='REJECT'

uci commit firewall
/etc/init.d/firewall restart
echo "Hardening applied."

