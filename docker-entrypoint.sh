#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
# or first arg is `something.conf`
if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
    set -- keydb-server "$@"
fi

# allow the container to be started with `--user`
if [ "$1" = 'keydb-server' -a "$(id -u)" = '0' ]; then
    find . \! -user vairogs -exec chown vairogs '{}' +
    exec su-exec keydb "$0" "$@"
fi

exec "$@"