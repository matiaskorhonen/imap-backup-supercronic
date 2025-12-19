FROM ghcr.io/joeyates/imap-backup:v16.2.0

LABEL org.opencontainers.image.description="A cron wrapper for imap-backup, using Supercronic"

WORKDIR /supercronic

# Install Supercronic
ARG TARGETARCH
ENV SUPERCRONIC_VERSION=v0.2.41

RUN apk update && apk add --no-cache curl \
    && case ${TARGETARCH} in \
         amd64) SUPERCRONIC_SHA1SUM=f70ad28d0d739a96dc9e2087ae370c257e79b8d7 ;; \
         arm64) SUPERCRONIC_SHA1SUM=44e10e33e8d98b1d1522f6719f15fb9469786ff0 ;; \
         *) echo "Unsupported architecture: ${TARGETARCH}" && exit 1 ;; \
       esac \
    && curl -fsSLO "https://github.com/aptible/supercronic/releases/download/${SUPERCRONIC_VERSION}/supercronic-linux-${TARGETARCH}" \
    && echo "${SUPERCRONIC_SHA1SUM}  supercronic-linux-${TARGETARCH}" | sha1sum -c - \
    && chmod +x "supercronic-linux-${TARGETARCH}" \
    && mv "supercronic-linux-${TARGETARCH}" "/usr/local/bin/supercronic"

COPY . .

ENTRYPOINT [ "./bin/entrypoint.sh" ]

CMD ["supercronic"]
