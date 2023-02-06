FROM library/debian:bullseye-slim

ARG id=1000
ARG name=dropbox

ENV data=/data

COPY --chown=root:root docker-entrypoint.sh /docker-entrypoint.sh
COPY --chown=root:root dropbox /usr/local/bin

RUN apt-get update \
 && apt-get dist-upgrade --assume-yes --no-install-recommends \
 && apt-get install --assume-yes --no-install-recommends ca-certificates curl python3 \
 && groupadd --gid ${id} ${name} \
 && useradd --home-dir /var/lib/dropbox --gid ${id} --create-home --no-user-group --uid ${id} --shell /bin/bash ${name} \
 && curl -fsSLo /opt/dropbox.py "https://www.dropbox.com/download?dl=packages/dropbox.py" \
 && chmod 0755 /docker-entrypoint.sh /usr/local/bin/dropbox

USER ${name}
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/var/lib/dropbox/.dropbox-dist/dropboxd"]
WORKDIR /var/lib/dropbox
