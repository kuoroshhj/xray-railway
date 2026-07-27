FROM alpine:3.19

RUN apk add --no-cache curl unzip ca-certificates

ARG XRAY_VERSION=26.3.27
RUN curl -sL "https://github.com/xtls/Xray-core/releases/download/v${XRAY_VERSION}/Xray-linux-64.zip" -o /tmp/xray.zip \
 && unzip /tmp/xray.zip -d /tmp/xray \
 && mv /tmp/xray/xray /usr/local/bin/ \
 && mv /tmp/xray/geoip.dat /usr/local/share/ \
 && mv /tmp/xray/geosite.dat /usr/local/share/ \
 && rm -rf /tmp/xray*

COPY config.json /etc/xray/config.json

EXPOSE 8080

CMD ["xray", "run", "-c", "/etc/xray/config.json"]
