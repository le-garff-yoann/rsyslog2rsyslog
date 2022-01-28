FROM alpine:3.7

RUN \
    apk update && \
    apk add rsyslog rsyslog-tls && \
    mkdir -p /var/spool/rsyslog /etc/rsyslog.d/ssl

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

CMD [ "/entrypoint.sh", "/usr/sbin/rsyslogd", "-n", "-i", "/var/run/rsyslogd.pid", "-f", "/etc/rsyslog.conf" ]
