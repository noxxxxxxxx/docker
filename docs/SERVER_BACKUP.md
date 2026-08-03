# Server Backup Guide

[中文](SERVER_BACKUP_ZH_CN.md)

Use `scripts/server-backup` for an encrypted, consistent backup of the public
repository and its private data root. It stops only the configured containers
that write into the data root, creates a gzip tar stream, encrypts it with GPG
before it reaches disk, verifies the encrypted archive locally, uploads it to
Qiniu, and confirms the remote object size before restarting the containers.

## Private configuration

Copy `scripts/server-backup.env.example` to a private location outside the
repository, replace every placeholder, and protect it together with the GPG
passphrase file:

```bash
chmod 600 /path/to/private-backup.env
chmod 600 /path/to/gpg-passphrase
```

The private configuration defines the repository root, private data root,
Qiniu client and bucket, passphrase file, and the complete list of containers
that write to the data root. It must never be committed.

## Run and schedule

Run one backup manually after configuration:

```bash
BACKUP_CONFIG_FILE=/path/to/private-backup.env ./scripts/server-backup
```

Schedule the same command with the server's scheduler only after the manual
run has succeeded. The script uploads two objects: an encrypted
`.tar.gz.gpg` archive and its `.sha256` sidecar file. It intentionally does
not delete remote backups; use a reviewed Qiniu lifecycle policy for retention.

## Recovery

Download both objects, check the checksum, then decrypt and inspect the
archive before restoring it. Continue with the service start order in the
[restore guide](SERVER_RESTORE.md). Keep the GPG passphrase and backup
configuration in a separate credential store; losing the passphrase makes the
backup unrecoverable.
