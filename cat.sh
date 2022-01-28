#!/usr/bin/env bash

docker exec -ti "$(docker-compose ps -q server)" cat /var/spool/rsyslog/inputs.log
