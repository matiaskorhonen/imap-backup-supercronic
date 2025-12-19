# imap-backup-supercronic

Scheduled email account backups.

Uses the [imap-backup](https://github.com/joeyates/imap-backup) Docker image and adds [supercronic](https://github.com/aptible/supercronic) to it.

## Usage

### Defaults

Run daily backups based on the config in `/data/config.json`:

**Docker**

```sh
docker run \
  --detach \
  --volume ./my-data:/data \
  ghcr.io/matiaskorhonen/imap-backup-supercronic:latest
```

**Docker Compose**

```yaml
services:
  imap-backup:
    image: ghcr.io/matiaskorhonen/imap-backup-supercronic:latest
    volumes:
      - ./my-data:/data
```

### Customize the schedule

See [crontab.guru](https://crontab.guru) for assistance with cron syntax.

**Docker**

```sh
docker run \
  --detach \
  --volume ./my-data:/data \
  --env BACKUP_SCHEDULE="15 * * * *"
  ghcr.io/matiaskorhonen/imap-backup-supercronic:latest
```

**Docker Compose**

```yaml
services:
  imap-backup:
    image: ghcr.io/matiaskorhonen/imap-backup-supercronic:latest
    volumes:
      - ./my-data:/data
    environment:
      BACKUP_SCHEDULE: "15 * * * *"
```

### Single account mode

Backup a single account with the default schedule (daily):

**Docker**

```sh
docker run \
  --detach \
  --volume ./my-data:/data \
  --env IMAP_BACKUP_ARGS="single backup --email me@example.com --password mysecret --server imap.example.com --path /data/me_example.com" \
  ghcr.io/matiaskorhonen/imap-backup-supercronic:latest
```

**Docker Compose**

```yaml
services:
  imap-backup:
    image: ghcr.io/matiaskorhonen/imap-backup-supercronic:latest
    volumes:
      - ./my-data:/data
    environment:
      IMAP_BACKUP_ARGS: "single backup
        --email me@example.com
        --password mysecret
        --server imap.example.com
        --path /data/me_example.com"
```
