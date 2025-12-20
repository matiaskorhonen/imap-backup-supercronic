# imap-backup-supercronic

Scheduled email account backups.

Uses the [imap-backup](https://github.com/joeyates/imap-backup) Docker image and adds [supercronic](https://github.com/aptible/supercronic) to it.

## Configuration

The `imap-backup` arguments and the schedule can be configured using environment variables:

* `BACKUP_SCHEDULE`: [supercronic compatible](https://github.com/aptible/supercronic/tree/main/cronexpr) cron schedule. Defaults to `@daily`.
* `IMAP_BACKUP_ARGS`: `imap-backup` command line arguments. Defaults to `backup --config /data/config.json`

See [crontab.guru](https://crontab.guru) for assistance with cron syntax.

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

## Versions

The versioning for the images aims to mirror the `imap-backup` versions. In
other words, imap-backup v16.2.0 is tagged as the `imap-backup-supercronic`
v16.2.0 image.

Additional fixes that don't change the `imap-backup` version are added as a
suffix to the version number. For example, v16.2.0.1 contained a Supercronic
version bump and other minor fixes.
