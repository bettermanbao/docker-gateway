#!/bin/sh

echo "nameserver 114.114.114.114" > /etc/resolv.conf

ipset restore -f /chnlist.ipset

iptables -t nat -A PREROUTING -p tcp -d $(ifconfig eth0 | awk '/inet addr/{print substr($2,6)}')/16 -j RETURN
iptables -t nat -A PREROUTING -p tcp -m set --match-set chnlist dst -j RETURN
iptables -t nat -A PREROUTING -p tcp -j REDIRECT --to-port 1081
iptables -t nat -A OUTPUT -p tcp -d 8.8.8.8 --dport 53 -j REDIRECT --to-port 1081

ip rule add fwmark 1 lookup 100
ip route add local 0.0.0.0/0 dev lo table 100
iptables -t mangle -N DIVERT
iptables -t mangle -A DIVERT -j MARK --set-mark 1
iptables -t mangle -A DIVERT -j ACCEPT
iptables -t mangle -A PREROUTING -p udp -m socket -j DIVERT
iptables -t mangle -A PREROUTING -p udp -d $(ifconfig eth0 | awk '/inet addr/{print substr($2,6)}')/16 -j RETURN
iptables -t mangle -A PREROUTING -p udp -m set --match-set chnlist dst -j RETURN
iptables -t mangle -A PREROUTING -p udp -j TPROXY --tproxy-mark 0x1/0x1 --on-port 1081

/ssr-redir -c /root/config.json -b 0.0.0.0 -l 1081 -u > /dev/null 2>&1 &
/ssr-local -c /root/config.json -b 0.0.0.0 -l 1080 -u > /dev/null 2>&1 &

/usr/sbin/dnsmasq
/dns-forwarder
