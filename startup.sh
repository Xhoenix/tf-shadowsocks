#!/bin/bash
apt update
apt install -y shadowsocks-libev haveged

# Set the password to our variable, listen on all interfaces(0.0.0.0), change server port to 8888 and set enable TCP Fast Open
sed -i 's/"password":".*",/"password":"${password}",/g' /etc/shadowsocks-libev/config.json
sed -i 's/"server":\["::1", "127.0.0.1"\],/"server":\["::0", "0.0.0.0"\],/g' /etc/shadowsocks-libev/config.json
sed -i 's/"server_port":8388,/"server_port":8888,/g' /etc/shadowsocks-libev/config.json
sed -i 's/"method":"chacha20-ietf-poly1305"/"method":"chacha20-ietf-poly1305",\n    "fast_open": true/g' /etc/shadowsocks-libev/config.json

# Enable TCP BBR and TCP Fast Open
echo "net.ipv4.tcp_fastopen=3" >> /etc/sysctl.conf
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
/usr/sbin/sysctl -p

# Restart Shadowsocks server to apply changes
/usr/sbin/service shadowsocks-libev restart
/usr/sbin/service shadowsocks-libev enable
