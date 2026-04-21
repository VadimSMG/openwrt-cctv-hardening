#!/bin/sh

# --- Loopback ---
uci set network.loopback=interface
uci set network.loopback.ifname='lo'
uci set network.loopback.proto='static'
uci set network.loopback.ipaddr='1.2.3.0'
uci set network.loopback.netmask='255.0.0.0'

# --- Globals ---
uci set network.globals=globals
uci set network.globals.ula_prefix='fd24:6794:9dfb::/48'

# --- LAN ---
uci set network.lan=interface
uci set network.lan.ifname='eth0'
uci set network.lan.force_link='1'
uci set network.lan.type='bridge'
uci set network.lan.proto='static'
uci set network.lan.ipaddr='1.2.3.1'
uci set network.lan.netmask='255.255.255.0'
uci set network.lan.ip6assign='60'

# --- WAN / WAN6 ---
uci set network.wan=interface
uci set network.wan.ifname='eth1'
uci set network.wan.proto='dhcp'

uci set network.wan6=interface
uci set network.wan6.ifname='eth1'
uci set network.wan6.proto='dhcpv6'

# --- Static Routes ---
# Route for 1.2.3.20
route_vigi=$(uci add network route)
uci set network.$route_vigi.interface='lan'
uci set network.$route_vigi.target='1.2.3.20'
uci set network.$route_vigi.gateway='1.2.3.1'

# Route for 1.2.3.21
route_hik1=$(uci add network route)
uci set network.$route_hik1.interface='lan'
uci set network.$route_hik1.target='1.2.3.21'
uci set network.$route_hik1.gateway='1.2.3.1'

# Route for 1.2.3.22
route_hik2=$(uci add network route)
uci set network.$route_hik2.interface='lan'
uci set network.$route_hik2.target='1.2.3.22'
uci set network.$route_hik2.gateway='1.2.3.1'

# --- Allow config ---
uci commit network
/etc/init.d/network restart
