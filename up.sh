#!/usr/bin/env bash

set -e

scriptdir=$(dirname $(readlink -f "$0"))

if [[ ! -d "$scriptdir/.ssl/" ]]
then
    mkdir -p "$scriptdir/.ssl/"

    pushd "$scriptdir/.ssl/"

    openssl genrsa -out ca.key 2048
    openssl req \
        -x509 -new -nodes \
        -key ca.key \
        -days 365 \
        -out ca.crt \
        -subj '/CN=rsyslog-ca'

    cat > server.cnf <<EOF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name

[req_distinguished_name]

[v3_req]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth, serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost
DNS.2 = server
IP.1 = 127.0.0.1
EOF

    openssl genrsa -out server.key 2048
    openssl req -new \
        -key server.key \
        -out server.csr \
        -subj '/CN=server' \
        -config server.cnf
    openssl x509 -req -CAcreateserial \
        -in server.csr \
        -CA ca.crt \
        -CAkey ca.key \
        -out server.crt \
        -days 365 \
        -extensions v3_req \
        -extfile server.cnf

    popd
fi

docker-compose down -v && \
docker-compose up -d --build --force-recreate
