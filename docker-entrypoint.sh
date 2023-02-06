#!/bin/sh
set -e

if [ ! -f "/var/lib/dropbox/.dropbox-dist/dropboxd" ]; then
    curl -fsSL "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
fi

HOME=${data}
export HOME

exec "$@"
