FROM alpine:latest
LABEL maintainer.name="Gilles GAUVENET" \
      version="0.0.1 Alpha" \
      description="OpenVPN client configured for SurfShark VPN"
ENV SURFSHARK_USER=
ENV SURFSHARK_PASSWORD=
ENV SURFSHARK_COUNTRY=fr
ENV CONNECTION_TYPE=udp
HEALTHCHECK --interval=60s --timeout=10s --start-period=30s CMD curl -s -L 'https://api.ipify.org'
RUN apk add --update --no-cache openvpn wget unzip coreutils curl
WORKDIR /vpn
COPY startup.sh /opt/startup.sh
RUN chmod +x /opt/startup.sh

ENTRYPOINT [ "/opt/startup.sh" ]
