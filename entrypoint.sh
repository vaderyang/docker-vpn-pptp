#!/bin/sh

set -e

# start logging
service rsyslog start

# enable IP forwarding
sysctl -w net.ipv4.ip_forward=1

# configure firewall
#iptables -t nat -A POSTROUTING -s 10.99.98.0/24 -o eth0 -j MASQUERADE
iptables -A FORWARD -s 192.168.134.0/24 -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -j TCPMSS --set-mss 1356

exec "$@"
