# RSyslog to RSyslog over syslog+tls

## Prerequisites

- Bash
- Docker and Docker Compose.
- OpenSSL.

## Setup

```bash
bash up.sh
```

## Read the logs received on the server

```bash
bash cat.sh
```

## Check Rsyslog logs

```bash
docker-compose logs -f
```
