#!/bin/bash
set -x

docker container rm --volumes surfshark01

rm -rfv ./h42-surfshark
git clone https://github.com/gilles67/h42-surfshark.git

cd ./h42-surfshark
sh dbuild.sh

cd -
rm -rfv ./h42-surfshark

docker volume create surfshark_data

docker create \
-v surfshark_data:/vpn \
-e SURFSHARK_USER= \
-e SURFSHARK_PASSWORD= \
-e SURFSHARK_COUNTRY=be,ch,nl \
-e CONNECTION_TYPE=udp \
--dns 1.1.1.1 \
--dns 1.0.0.1 \
--cap-add=NET_ADMIN \
--device /dev/net/tun \
--name surfshark01 \
--restart always \
h42-surfshark

test "$1" = "start" && docker start surfshark01
