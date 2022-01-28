#!/usr/bin/env bash

docker exec -ti "$(docker-compose ps -q "${1:-server}")" sh
