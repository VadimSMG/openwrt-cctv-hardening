#!/bin/sh
# Torn off all wireless interfaces
uci set wireless.radio0.disabled='1'
uci set wireless.radio1.disabled='1' # for second radio
uci commit wireless
wifi reload
