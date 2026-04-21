#!/bin/sh
# General politics
#
echo "Configuring Firewall Zones..."

# WAN Zone (Hardening input)
uci set firewall.@zone[1].input='REJECT'
uci set firewall.@zone[1].forward='REJECT'
uci set firewall.@zone[1].masq='1'
uci set firewall.@zone[1].mtu_fix='1'

# LAN Zone (Allowing local)
uci set firewall.@zone[0].input='ACCEPT'
uci set firewall.@zone[0].forward='ACCEPT'

uci commit firewall
/etc/init.d/firewall restart
echo "Zones configured."
