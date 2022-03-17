#!/bin/sh

set -e

cp -fr /tmp/rsyslog.conf /etc/rsyslog.conf
find /tmp/.ssl -mindepth 1 -exec cp -f {} /etc/rsyslog.d/ssl \;

chown -R root:root /etc/rsyslog.conf
find /etc/rsyslog.d/ssl -mindepth 1 -exec chmod 640 {} \;
find /etc/rsyslog.d/ssl -mindepth 1 -exec chown root:root {} \;
find /etc/rsyslog.d/ssl -mindepth 1 -name *.key -exec chmod 400 {} \;
find /etc/rsyslog.d/ssl -mindepth 1 -name *.key -exec chown root:root {} \;

touch /var/spool/rsyslog/known.log;
touch /var/spool/rsyslog/default.log

exec "$@"
