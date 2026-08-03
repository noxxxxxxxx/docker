# Server Restore Guide

This repository contains only public Compose definitions. Runtime data,
certificates, service configuration, and credentials must remain outside Git
and be restored from an encrypted backup.

In the private deployment environment, set the following values before using
the server launcher:

```bash
export REPO_ROOT=/path/to/repository
export DATA_ROOT=/path/to/private-data
```

`DATA_ROOT` must contain the `runtime`, `config`, `secrets`, `certificates`,
and `backups` directories. Download the matching encrypted backup, verify its
SHA-256 sidecar file, decrypt it, and restore both the repository and data
root. Then start services in dependency order:

```bash
./scripts/server-compose mariadb up -d
./scripts/server-compose redis up -d
./scripts/server-compose gitea up -d
./scripts/server-compose sonarqube up -d
./scripts/server-compose verdoccio up -d
./scripts/server-compose php_fpm up -d
./scripts/server-compose nginx up -d
```

Do not commit deployment paths, host addresses, certificates, `.env` files,
database data, user uploads, or backup archives. See
[the backup guide](SERVER_BACKUP.md) for the backup process.
