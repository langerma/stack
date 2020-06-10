FROM python:3.8-alpine

RUN apk --no-cache --update upgrade && \
    apk --no-cache add bash unbound drill && \
    rm -rf /var/cache/apk/*

RUN pip install requests

ADD https://github.com/just-containers/s6-overlay/releases/latest/download/s6-overlay-amd64.tar.gz \
    /tmp/s6-overlay-amd64.tar.gz

RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / && \
    rm -f /tmp/s6-overlay-amd64.tar.gz

ENTRYPOINT ["/init"]
CMD ["/usr/sbin/unbound", "-d", "-v"]
