FROM ghcr.io/joeyates/imap-backup:v16.2.0

WORKDIR /supercronic

# Install Supercronic
ARG TARGETARCH
ENV SUPERCRONIC_VERSION=v0.2.33

RUN apk update && apk add --no-cache curl \
    && case ${TARGETARCH} in \
         amd64) SUPERCRONIC_SHA1SUM=71b0d58cc53f6bd72cf2f293e09e294b79c666d8 ;; \
         arm64) SUPERCRONIC_SHA1SUM=d5e02aa760b3d434bc7b991777aa89ef4a503e49 ;; \
         *) echo "Unsupported architecture: ${TARGETARCH}" && exit 1 ;; \
       esac \
    && curl -fsSLO "https://github.com/aptible/supercronic/releases/download/${SUPERCRONIC_VERSION}/supercronic-linux-${TARGETARCH}" \
    && echo "${SUPERCRONIC_SHA1SUM}  supercronic-linux-${TARGETARCH}" | sha1sum -c - \
    && chmod +x "supercronic-linux-${TARGETARCH}" \
    && mv "supercronic-linux-${TARGETARCH}" "/usr/local/bin/supercronic"

COPY . .

ENTRYPOINT [ "./bin/entrypoint.sh" ]

CMD ["supercronic"]
