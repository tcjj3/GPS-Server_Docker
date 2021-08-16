FROM debian:buster-slim

LABEL maintainer "Chaojun Tan <https://github.com/tcjj3>"

ADD entrypoint.sh /opt/entrypoint.sh

RUN export DIR_TMP="$(mktemp -d)" \
  && cd ${DIR_TMP} \
  && sed -i "s/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list \
  && sed -i "s/security.debian.org/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list \
  && apt-get update \
  || echo "continue..." \
  && apt-get install --no-install-recommends -y wget \
                                                ca-certificates \
                                                curl \
                                                gpsd gpsd-clients python-gps ntp \
                                                procps \
                                                psmisc \
                                                net-tools \
  || apt-get install --no-install-recommends -y wget \
                                                ca-certificates \
                                                curl \
                                                gpsd gpsd-clients python3-gps ntp \
                                                procps \
                                                psmisc \
                                                net-tools \
  && chmod +x /opt/*.sh \
  && mv /etc/ntp.conf /etc/ntp.conf.bak \
  && grep -v "^pool " /etc/ntp.conf.bak > /etc/ntp.conf \
  && echo "server 127.127.28.0 minpoll 4" >> /etc/ntp.conf \
  && echo "fudge 127.127.28.0 time1 0.0 refid NMEA" >> /etc/ntp.conf \
  && rm -rf ${DIR_TMP}











ENTRYPOINT ["sh", "-c", "/opt/entrypoint.sh"]











