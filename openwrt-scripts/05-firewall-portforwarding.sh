#!/bin/sh
# Portforwarding for NVR TP-LINK VIGI

NVR_IP="1.2.3.20"

echo "Configuring Port Forwarding for NVR $NVR_IP..."

# RTSP Port
r_rtsp=$(uci add firewall redirect)
uci set firewall.$r_rtsp.name='EDKI-RTSP'
uci set firewall.$r_rtsp.src='wan'
uci set firewall.$r_rtsp.dest='lan'
uci set firewall.$r_rtsp.proto='tcp udp'
uci set firewall.$r_rtsp.src_dport='554'
uci set firewall.$r_rtsp.dest_ip="$NVR_IP"
uci set firewall.$r_rtsp.dest_port='554'

# Data Port (VIGI Manager)
r_data=$(uci add firewall redirect)
uci set firewall.$r_data.name='EDKI-Data'
uci set firewall.$r_data.src='wan'
uci set firewall.$r_data.dest='lan'
uci set firewall.$r_data.proto='tcp'
uci set firewall.$r_data.src_dport='8000'
uci set firewall.$r_data.dest_ip="$NVR_IP"
uci set firewall.$r_data.dest_port='8000'

uci commit firewall
/etc/init.d/firewall restart
echo "Port forwarding ready."
