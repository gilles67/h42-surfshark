#!/bin/sh
if test ! -d ./ovpn_configs ; then
  wget -O ovpn_configs.zip https://api.surfshark.com/v1/server/configurations
  unzip ovpn_configs.zip -d ovpn_configs
fi
cd ovpn_configs

test -z "${SURFSHARK_COUNTRY}" && echo "No country selected (SURFSHARK_COUNTRY) " && exit 1

FILTER=""
COUNTRIES=$(echo $SURFSHARK_COUNTRY | tr "," "\n")
for COUNTRY in $COUNTRIES; do
  FILTER="$FILTER -e $COUNTRY-"
done

VPN_FILE=$(ls | grep $FILTER | grep -e "_${CONNECTION_TYPE}" | shuf | head -n 1)

echo Choosed: ${VPN_FILE}

test -z "${SURFSHARK_USER}" && echo "Missing SurfShark Username (SURFSHARK_USER) " && exit 1
test -z "${SURFSHARK_PASSWORD}" && echo "Missing SurfShark Password (SURFSHARK_PASSWORD)" && exit 1

printf "${SURFSHARK_USER}\n${SURFSHARK_PASSWORD}" > vpn-auth.txt

openvpn --config $VPN_FILE --auth-user-pass vpn-auth.txt
