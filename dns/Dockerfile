FROM pihole/pihole

RUN export TERM=dumb DEBIAN_FRONTEND=noninteractive \
    && apt-get -y update \
    && apt-get -y install \
    unbound \
    && rm -rf /var/lib/apt/lists/*

COPY rootfs /

RUN chown unbound: -R /var/lib/unbound
